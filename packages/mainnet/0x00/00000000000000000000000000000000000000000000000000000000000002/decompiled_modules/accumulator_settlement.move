module 0x2::accumulator_settlement {
    struct EventStreamHead has store {
        mmr: vector<u256>,
        checkpoint_seq: u64,
        num_events: u64,
    }

    fun add_to_mmr(arg0: u256, arg1: &mut vector<u256>) {
        let v0 = 0;
        let v1 = arg0;
        while (v0 < 0x1::vector::length<u256>(arg1)) {
            let v2 = 0x1::vector::borrow_mut<u256>(arg1, v0);
            if (*v2 == 0) {
                *v2 = v1;
                return
            };
            v1 = hash_two_to_one_u256(*v2, v1);
            *v2 = 0;
            v0 = v0 + 1;
        };
        0x1::vector::push_back<u256>(arg1, v1);
    }

    fun hash_two_to_one_u256(arg0: u256, arg1: u256) : u256 {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg1));
        u256_from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun new_stream_head(arg0: u256, arg1: u64, arg2: u64) : EventStreamHead {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        add_to_mmr(arg0, v1);
        EventStreamHead{
            mmr            : v0,
            checkpoint_seq : arg2,
            num_events     : arg1,
        }
    }

    native fun record_settlement_sui_conservation(arg0: u64, arg1: u64);
    fun settle_events(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: address, arg2: u256, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == @0x0, 0);
        let v0 = 0x2::accumulator::accumulator_key<EventStreamHead>(arg1);
        if (0x2::accumulator::root_has_accumulator<EventStreamHead, EventStreamHead>(arg0, v0)) {
            let v1 = 0x2::accumulator::root_borrow_accumulator_mut<EventStreamHead, EventStreamHead>(arg0, v0);
            let v2 = &mut v1.mmr;
            add_to_mmr(arg2, v2);
            v1.num_events = v1.num_events + arg3;
            v1.checkpoint_seq = arg4;
        } else {
            0x2::accumulator::root_add_accumulator<EventStreamHead, EventStreamHead>(arg0, v0, new_stream_head(arg2, arg3, arg4));
        };
    }

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

    fun settlement_prologue(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == @0x0, 0);
        record_settlement_sui_conservation(arg4, arg5);
    }

    fun u256_from_bytes(arg0: vector<u8>) : u256 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u256(&mut v0)
    }

    // decompiled from Move bytecode v6
}

