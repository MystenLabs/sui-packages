module 0xab3342c8b949ff7874c7b918f3558a77d2d7965abc253a4230e6c3127aa07dd2::navi_adapter_event {
    struct NewNaviVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct NewNaviPositionEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

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

    public fun new_navi_position_event(arg0: 0x2::object::ID) {
        let v0 = NewNaviPositionEvent{vault_id: arg0};
        0x2::event::emit<NewNaviPositionEvent>(v0);
    }

    public fun new_navi_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewNaviVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewNaviVaultEvent>(v0);
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

