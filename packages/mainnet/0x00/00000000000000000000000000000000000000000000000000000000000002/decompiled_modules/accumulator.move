module 0x2::accumulator {
    struct AccumulatorRoot has key {
        id: 0x2::object::UID,
    }

    fun create(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 0);
        let v0 = AccumulatorRoot{id: 0x2::object::sui_accumulator_root_object_id()};
        0x2::transfer::share_object<AccumulatorRoot>(v0);
    }

    // decompiled from Move bytecode v6
}

