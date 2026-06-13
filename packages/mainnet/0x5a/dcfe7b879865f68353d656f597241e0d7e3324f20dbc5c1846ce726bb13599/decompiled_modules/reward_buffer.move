module 0x5adcfe7b879865f68353d656f597241e0d7e3324f20dbc5c1846ce726bb13599::reward_buffer {
    struct RewardBufferKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    public fun add<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<RewardBufferKey>(arg0, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0);
            0x2::balance::join<T0>(v2, arg1);
            0x2::balance::value<T0>(v2)
        } else if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            0
        } else {
            0x2::dynamic_field::add<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
            0x2::balance::value<T0>(&arg1)
        }
    }

    public fun take<T0>(arg0: &mut 0x2::object::UID) : 0x2::balance::Balance<T0> {
        let v0 = RewardBufferKey{coin: 0x1::type_name::with_defining_ids<T0>()};
        if (0x2::dynamic_field::exists<RewardBufferKey>(arg0, v0)) {
            0x2::dynamic_field::remove<RewardBufferKey, 0x2::balance::Balance<T0>>(arg0, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v7
}

