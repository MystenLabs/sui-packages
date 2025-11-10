module 0xb0afdd964ee171c6187df826992dc08890bf6cbea73e8399a21795b0935e4833::kiosk_transfer_guard {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        global_id: 0x2::object::ID,
    }

    public fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xb0afdd964ee171c6187df826992dc08890bf6cbea73e8399a21795b0935e4833::kiosk_staking::Global) {
        let v0 = Config{global_id: 0x2::object::id<0xb0afdd964ee171c6187df826992dc08890bf6cbea73e8399a21795b0935e4833::kiosk_staking::Global>(arg2)};
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v1, arg0, arg1, v0);
    }

    public fun ensure_unstaked<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &0xb0afdd964ee171c6187df826992dc08890bf6cbea73e8399a21795b0935e4833::kiosk_staking::Global, arg2: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Rule{dummy_field: false};
        assert!(0x2::object::id<0xb0afdd964ee171c6187df826992dc08890bf6cbea73e8399a21795b0935e4833::kiosk_staking::Global>(arg1) == 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).global_id, 0);
        assert!(!0xb0afdd964ee171c6187df826992dc08890bf6cbea73e8399a21795b0935e4833::kiosk_staking::is_staked(arg1, 0x2::transfer_policy::item<T0>(arg2)), 1);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg2);
    }

    // decompiled from Move bytecode v6
}

