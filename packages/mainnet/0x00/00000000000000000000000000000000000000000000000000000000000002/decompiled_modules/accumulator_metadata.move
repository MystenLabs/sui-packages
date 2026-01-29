module 0x2::accumulator_metadata {
    struct OwnerKey has copy, drop, store {
        owner: address,
    }

    struct Owner has store {
        balances: 0x2::bag::Bag,
        owner: address,
    }

    struct MetadataKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Metadata<phantom T0> has store {
        fields: 0x2::bag::Bag,
    }

    struct AccumulatorObjectCountKey has copy, drop, store {
        dummy_field: bool,
    }

    fun get_accumulator_object_count(arg0: &0x2::accumulator::AccumulatorRoot) : u64 {
        let v0 = AccumulatorObjectCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<AccumulatorObjectCountKey>(0x2::accumulator::root_id(arg0), v0)) {
            *0x2::dynamic_field::borrow<AccumulatorObjectCountKey, u64>(0x2::accumulator::root_id(arg0), v0)
        } else {
            0
        }
    }

    fun record_accumulator_object_changes(arg0: &mut 0x2::accumulator::AccumulatorRoot, arg1: u64, arg2: u64) {
        let v0 = AccumulatorObjectCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<AccumulatorObjectCountKey>(0x2::accumulator::root_id_mut(arg0), v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<AccumulatorObjectCountKey, u64>(0x2::accumulator::root_id_mut(arg0), v0);
            assert!(*v1 + arg1 >= arg2, 0);
            *v1 = *v1 + arg1 - arg2;
        } else {
            assert!(arg1 >= arg2, 0);
            0x2::dynamic_field::add<AccumulatorObjectCountKey, u64>(0x2::accumulator::root_id_mut(arg0), v0, arg1 - arg2);
        };
    }

    // decompiled from Move bytecode v6
}

