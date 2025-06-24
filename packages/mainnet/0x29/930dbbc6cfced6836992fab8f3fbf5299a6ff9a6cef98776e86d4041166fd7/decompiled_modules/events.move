module 0x639386e63bccd376927b03605100eb314a5be5102d846d6ee6bb0f27e79df8b9::events {
    struct FeeCollected<phantom T0, phantom T1> has copy, drop {
        lp_vault_id: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
        epoch: u64,
        collector: address,
        timestamp: u64,
    }

    struct FeeClaimed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount_a: u64,
        amount_b: u64,
        user_amount: u64,
        total_contribution: u64,
        epoch: u64,
    }

    struct LpVaultCreated<phantom T0, phantom T1> has copy, drop {
        market_id: 0x2::object::ID,
        lp_vault_id: 0x2::object::ID,
        curator: address,
        pool_address: address,
        initialize_price: u128,
        liquidity_amount: u64,
        token_amount: u64,
        position_id: 0x2::object::ID,
    }

    struct VaultCreated<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        curator: address,
        admin_public_key: vector<u8>,
        epoch: u64,
    }

    public fun emit_fee_claimed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = FeeClaimed<T0, T1>{
            vault_id           : arg0,
            user               : arg1,
            amount_a           : arg2,
            amount_b           : arg3,
            user_amount        : arg4,
            total_contribution : arg5,
            epoch              : arg6,
        };
        0x2::event::emit<FeeClaimed<T0, T1>>(v0);
    }

    public fun emit_fee_collected<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        let v0 = FeeCollected<T0, T1>{
            lp_vault_id : arg0,
            fee_a       : arg1,
            fee_b       : arg2,
            epoch       : arg3,
            collector   : arg4,
            timestamp   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<FeeCollected<T0, T1>>(v0);
    }

    public fun emit_lp_vault_created<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: u128, arg5: u64, arg6: u64, arg7: 0x2::object::ID) {
        let v0 = LpVaultCreated<T0, T1>{
            market_id        : arg0,
            lp_vault_id      : arg1,
            curator          : arg2,
            pool_address     : arg3,
            initialize_price : arg4,
            liquidity_amount : arg5,
            token_amount     : arg6,
            position_id      : arg7,
        };
        0x2::event::emit<LpVaultCreated<T0, T1>>(v0);
    }

    public fun emit_vault_created<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: u64) {
        let v0 = VaultCreated<T0, T1>{
            vault_id         : arg0,
            curator          : arg1,
            admin_public_key : arg2,
            epoch            : arg3,
        };
        0x2::event::emit<VaultCreated<T0, T1>>(v0);
    }

    public fun get_id(arg0: &0x2::object::UID) : 0x2::object::ID {
        0x2::object::id_from_bytes(0x2::object::uid_to_bytes(arg0))
    }

    // decompiled from Move bytecode v6
}

