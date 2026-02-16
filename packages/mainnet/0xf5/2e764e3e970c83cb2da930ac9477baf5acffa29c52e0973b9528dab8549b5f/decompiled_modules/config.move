module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config {
    struct DepositFeeBpsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CutoffKey has copy, drop, store {
        pos0: u8,
    }

    public(friend) fun cutoff_ms(arg0: &0x2::object::UID, arg1: u8) : u64 {
        let v0 = CutoffKey{pos0: arg1};
        if (0x2::dynamic_field::exists_<CutoffKey>(arg0, v0)) {
            *0x2::dynamic_field::borrow<CutoffKey, u64>(arg0, v0)
        } else {
            let v2 = &arg1;
            if (*v2 == 0) {
                420000
            } else if (*v2 == 1) {
                600000
            } else if (*v2 == 2) {
                1800000
            } else if (*v2 == 3) {
                3600000
            } else if (*v2 == 4) {
                180000
            } else {
                600000
            }
        }
    }

    public(friend) fun deposit_fee_bps(arg0: &0x2::object::UID) : u16 {
        let v0 = DepositFeeBpsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<DepositFeeBpsKey>(arg0, v0)) {
            let v2 = DepositFeeBpsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DepositFeeBpsKey, u16>(arg0, v2)
        } else {
            0
        }
    }

    public(friend) fun init_cutoff_config(arg0: &mut 0x2::object::UID) {
        let v0 = CutoffKey{pos0: 0};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v0, 420000);
        let v1 = CutoffKey{pos0: 1};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v1, 600000);
        let v2 = CutoffKey{pos0: 2};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v2, 1800000);
        let v3 = CutoffKey{pos0: 3};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v3, 3600000);
        let v4 = CutoffKey{pos0: 4};
        0x2::dynamic_field::add<CutoffKey, u64>(arg0, v4, 180000);
    }

    public(friend) fun init_deposit_fee(arg0: &mut 0x2::object::UID, arg1: u16) {
        let v0 = DepositFeeBpsKey{dummy_field: false};
        0x2::dynamic_field::add<DepositFeeBpsKey, u16>(arg0, v0, arg1);
    }

    public(friend) fun set_cutoff(arg0: &mut 0x2::object::UID, arg1: u8, arg2: u64) {
        let v0 = CutoffKey{pos0: arg1};
        if (0x2::dynamic_field::exists_<CutoffKey>(arg0, v0)) {
            *0x2::dynamic_field::borrow_mut<CutoffKey, u64>(arg0, v0) = arg2;
        } else {
            0x2::dynamic_field::add<CutoffKey, u64>(arg0, v0, arg2);
        };
    }

    public(friend) fun set_deposit_fee(arg0: &mut 0x2::object::UID, arg1: u16) {
        let v0 = DepositFeeBpsKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<DepositFeeBpsKey, u16>(arg0, v0) = arg1;
    }

    // decompiled from Move bytecode v6
}

