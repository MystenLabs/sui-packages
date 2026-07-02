module 0xf21b9bfedfe020b53c5ea120bd187d4e824e0fbae977cc94ebf1896ac0692ba::suilend_adapter_event {
    struct SuilendSupplyEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct SuilendWithdrawEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct SuilendClaimEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct SuilendBorrowEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct SuilendRepayEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SuilendBorrowEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendBorrowEvent<T0>>(v0);
    }

    public fun claim_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SuilendClaimEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendClaimEvent<T0>>(v0);
    }

    public fun repay_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SuilendRepayEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendRepayEvent<T0>>(v0);
    }

    public fun supply_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SuilendSupplyEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendSupplyEvent<T0>>(v0);
    }

    public fun withdraw_event<T0>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = SuilendWithdrawEvent<T0>{
            vault_id : arg0,
            amount   : arg1,
        };
        0x2::event::emit<SuilendWithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

