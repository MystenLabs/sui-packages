module 0x8555bc7e969672d2c69de703d6fc775d2993a829b67e1e893c66c1e229010b10::scallop_adapter_event {
    struct NewScallopVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct NewScallopPositionEvent has copy, drop {
        vault_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
    }

    struct ScallopSupplyEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopWithdrawEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopClaimEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopCollateralEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopBorrowEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopRepayEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct ScallopWithdrawCollateralEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopBorrowEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopBorrowEvent<T0>>(v0);
    }

    public fun claim_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopClaimEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopClaimEvent<T0>>(v0);
    }

    public fun collateral_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopCollateralEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopCollateralEvent<T0>>(v0);
    }

    public fun new_scallop_position_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewScallopPositionEvent{
            vault_id      : arg0,
            obligation_id : arg1,
        };
        0x2::event::emit<NewScallopPositionEvent>(v0);
    }

    public fun new_scallop_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewScallopVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewScallopVaultEvent>(v0);
    }

    public fun repay_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopRepayEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopRepayEvent<T0>>(v0);
    }

    public fun supply_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopSupplyEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopSupplyEvent<T0>>(v0);
    }

    public fun withdraw_collateral_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopWithdrawCollateralEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopWithdrawCollateralEvent<T0>>(v0);
    }

    public fun withdraw_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ScallopWithdrawEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<ScallopWithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

