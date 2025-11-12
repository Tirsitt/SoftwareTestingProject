// dock_model.pml
/* Simple Promela model: multiple ships using limited docks */

int docks = 2;

proctype Ship(byte id) {
    bool indock = false;

    /* Try to acquire a dock */
    atomic {
        if
        :: (docks > 0) -> docks = docks - 1; indock = true;
        :: else -> skip
        fi
    }

    /* Only proceed if dock acquired */
    if
    :: (indock) ->
        /* Simulate using the dock (abstract) */
        /* loading/unloading operation */
        
        /* Release the dock */
        atomic { docks = docks + 1; indock = false; }
    :: else -> skip
    fi
}

init {
    /* Spawn multiple ships */
    run Ship(0)
    run Ship(1)
    run Ship(2)
    run Ship(3)
    run Ship(4)

    /* Safety check */
    assert(docks >= 0 && docks <= 2)
}