module 0x2::accumulator_settlement {
    fun settle_u128<T0>(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: address, arg2: u128, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x0, 0);
        assert!(arg2 == 0 != arg3 == 0, 1);
        let v0 = 0x2::accumulator::accumulator_key<T0>(arg1);
        if (0x2::accumulator::root_has_accumulator<T0, 0x2::accumulator::U128>(arg0, v0)) {
            let v1 = 0x2::accumulator::root_borrow_accumulator_mut<T0, 0x2::accumulator::U128>(arg0, v0);
            0x2::accumulator::update_u128(v1, arg2, arg3);
            if (0x2::accumulator::is_zero_u128(v1)) {
                0x2::accumulator::destroy_u128(0x2::accumulator::root_remove_accumulator<T0, 0x2::accumulator::U128>(arg0, v0));
                0x2::accumulator_metadata::remove_accumulator_metadata<T0>(arg0, arg1);
            };
        } else {
            assert!(arg3 == 0, 1);
            0x2::accumulator::root_add_accumulator<T0, 0x2::accumulator::U128>(arg0, v0, 0x2::accumulator::create_u128(arg2));
            0x2::accumulator_metadata::create_accumulator_metadata<T0>(arg0, arg1, arg4);
        };
    }

    fun settlement_prologue(arg0: u64, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x0, 0);
    }

    // decompiled from Move bytecode v6
}

