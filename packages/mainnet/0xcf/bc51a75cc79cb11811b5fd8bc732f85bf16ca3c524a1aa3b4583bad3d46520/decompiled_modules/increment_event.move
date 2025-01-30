module 0xcfbc51a75cc79cb11811b5fd8bc732f85bf16ca3c524a1aa3b4583bad3d46520::increment_event {
    struct IncrementEvent has copy, drop {
        value: u32,
    }

    public fun new(arg0: u32) : IncrementEvent {
        IncrementEvent{value: arg0}
    }

    // decompiled from Move bytecode v6
}

