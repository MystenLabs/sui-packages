module 0xa862248b45fdf345238365de7faf406b47ef18edef16797322c47872146c1a3d::navi_adapter_event {
    struct NaviSupplyEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct NaviWithdrawEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct NaviClaimEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct NaviBorrowEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct NaviRepayEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = NaviBorrowEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviBorrowEvent<T0>>(v0);
    }

    public fun claim_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = NaviClaimEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviClaimEvent<T0>>(v0);
    }

    public fun repay_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = NaviRepayEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviRepayEvent<T0>>(v0);
    }

    public fun supply_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = NaviSupplyEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviSupplyEvent<T0>>(v0);
    }

    public fun withdraw_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = NaviWithdrawEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<NaviWithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

