module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::config {
    struct DepositFeeBpsKey has copy, drop, store {
        dummy_field: bool,
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

    public(friend) fun init_deposit_fee(arg0: &mut 0x2::object::UID, arg1: u16) {
        let v0 = DepositFeeBpsKey{dummy_field: false};
        0x2::dynamic_field::add<DepositFeeBpsKey, u16>(arg0, v0, arg1);
    }

    public(friend) fun set_deposit_fee(arg0: &mut 0x2::object::UID, arg1: u16) {
        let v0 = DepositFeeBpsKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<DepositFeeBpsKey, u16>(arg0, v0) = arg1;
    }

    // decompiled from Move bytecode v6
}

