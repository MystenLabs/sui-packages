module 0xf0b73eb2fe38202bbab033378b47ce46e5e7b379e682dae2b55dead078454f67::alphalend_adapter_event {
    struct NewAlphalendVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct NewAlphalendPositionEvent has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct AlphalendCollateralEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct AlphalendWithdrawCollateralEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct AlphalendBorrowEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct AlphalendRepayEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct AlphalendClaimEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AlphalendBorrowEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AlphalendBorrowEvent<T0>>(v0);
    }

    public fun claim_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AlphalendClaimEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AlphalendClaimEvent<T0>>(v0);
    }

    public fun collateral_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AlphalendCollateralEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AlphalendCollateralEvent<T0>>(v0);
    }

    public fun new_alphalend_position_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewAlphalendPositionEvent{
            vault_id    : arg0,
            position_id : arg1,
        };
        0x2::event::emit<NewAlphalendPositionEvent>(v0);
    }

    public fun new_alphalend_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewAlphalendVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewAlphalendVaultEvent>(v0);
    }

    public fun repay_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AlphalendRepayEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AlphalendRepayEvent<T0>>(v0);
    }

    public fun withdraw_collateral_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = AlphalendWithdrawCollateralEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<AlphalendWithdrawCollateralEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

