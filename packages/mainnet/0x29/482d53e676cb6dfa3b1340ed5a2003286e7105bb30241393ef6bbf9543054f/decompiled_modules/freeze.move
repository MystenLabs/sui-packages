module 0x29482d53e676cb6dfa3b1340ed5a2003286e7105bb30241393ef6bbf9543054f::freeze {
    public entry fun freeze_treasury_cap<T0>(arg0: 0x2::coin::TreasuryCap<T0>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

