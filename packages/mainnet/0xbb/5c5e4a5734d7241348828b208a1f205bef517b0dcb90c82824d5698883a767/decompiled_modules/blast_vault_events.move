module 0xbb5c5e4a5734d7241348828b208a1f205bef517b0dcb90c82824d5698883a767::blast_vault_events {
    struct VaultCreated<phantom T0, phantom T1, phantom T2> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        liquidity: u128,
        terms: 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::migration::VaultTerms,
        residual_meme_amount: u64,
        residual_quote_amount: u64,
    }

    struct FeesCollected<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        gross_meme_amount: u64,
        gross_quote_amount: u64,
        protocol_meme_amount: u64,
        protocol_quote_amount: u64,
        route_meme_amounts: vector<u64>,
        route_quote_amounts: vector<u64>,
    }

    struct AutoLpPositionOpened<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
    }

    struct AutoLiquidityAdded<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
        auto_lp_meme_pending: u64,
        auto_lp_quote_pending: u64,
    }

    struct BuybackBurned<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        quote_spent: u64,
        meme_burned: u64,
        burn_quote_pending: u64,
    }

    struct OwnerBalancesClaimed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct RoundPublished<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        start_checkpoint: u64,
        end_checkpoint: u64,
        claim_deadline_at_ms: u64,
        root: vector<u8>,
        manifest_digest: vector<u8>,
        leaf_count: u64,
        meme_amount: u64,
        quote_amount: u64,
        meme_unallocated: u64,
        quote_unallocated: u64,
        treasury: address,
        gas_reserve_amount: u64,
    }

    struct RewardClaimed<phantom T0, phantom T1> has copy, drop {
        round_id: 0x2::object::ID,
        index: u64,
        beneficiary: address,
        meme_amount: u64,
        quote_amount: u64,
        meme_remaining: u64,
        quote_remaining: u64,
    }

    struct GasReserveSettled<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        treasury: address,
        reimbursement_amount: u64,
        reserve_returned: u64,
        quote_unallocated: u64,
    }

    struct RoundClosed<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        round_id: 0x2::object::ID,
        number: u64,
        meme_returned: u64,
        quote_returned: u64,
        gas_reserve_returned: u64,
    }

    public(friend) fun auto_liquidity_added<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AutoLiquidityAdded<T0, T1>{
            vault_id              : arg0,
            meme_amount           : arg1,
            quote_amount          : arg2,
            auto_lp_meme_pending  : arg3,
            auto_lp_quote_pending : arg4,
        };
        0x2::event::emit<AutoLiquidityAdded<T0, T1>>(v0);
    }

    public(friend) fun auto_lp_position_opened<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = AutoLpPositionOpened<T0, T1>{
            vault_id    : arg0,
            position_id : arg1,
        };
        0x2::event::emit<AutoLpPositionOpened<T0, T1>>(v0);
    }

    public(friend) fun buyback_burned<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = BuybackBurned<T0, T1>{
            vault_id           : arg0,
            quote_spent        : arg1,
            meme_burned        : arg2,
            burn_quote_pending : arg3,
        };
        0x2::event::emit<BuybackBurned<T0, T1>>(v0);
    }

    public(friend) fun fees_collected<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u64>, arg6: vector<u64>) {
        let v0 = FeesCollected<T0, T1>{
            vault_id              : arg0,
            gross_meme_amount     : arg1,
            gross_quote_amount    : arg2,
            protocol_meme_amount  : arg3,
            protocol_quote_amount : arg4,
            route_meme_amounts    : arg5,
            route_quote_amounts   : arg6,
        };
        0x2::event::emit<FeesCollected<T0, T1>>(v0);
    }

    public(friend) fun gas_reserve_settled<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = GasReserveSettled<T0, T1>{
            vault_id             : arg0,
            round_id             : arg1,
            number               : arg2,
            treasury             : arg3,
            reimbursement_amount : arg4,
            reserve_returned     : arg5,
            quote_unallocated    : arg6,
        };
        0x2::event::emit<GasReserveSettled<T0, T1>>(v0);
    }

    public(friend) fun owner_balances_claimed<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = OwnerBalancesClaimed<T0, T1>{
            vault_id     : arg0,
            meme_amount  : arg1,
            quote_amount : arg2,
        };
        0x2::event::emit<OwnerBalancesClaimed<T0, T1>>(v0);
    }

    public(friend) fun reward_claimed<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = RewardClaimed<T0, T1>{
            round_id        : arg0,
            index           : arg1,
            beneficiary     : arg2,
            meme_amount     : arg3,
            quote_amount    : arg4,
            meme_remaining  : arg5,
            quote_remaining : arg6,
        };
        0x2::event::emit<RewardClaimed<T0, T1>>(v0);
    }

    public(friend) fun round_closed<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = RoundClosed<T0, T1>{
            vault_id             : arg0,
            round_id             : arg1,
            number               : arg2,
            meme_returned        : arg3,
            quote_returned       : arg4,
            gas_reserve_returned : arg5,
        };
        0x2::event::emit<RoundClosed<T0, T1>>(v0);
    }

    public(friend) fun round_published<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u64) {
        let v0 = RoundPublished<T0, T1>{
            vault_id             : arg0,
            round_id             : arg1,
            number               : arg2,
            start_checkpoint     : arg3,
            end_checkpoint       : arg4,
            claim_deadline_at_ms : arg5,
            root                 : arg6,
            manifest_digest      : arg7,
            leaf_count           : arg8,
            meme_amount          : arg9,
            quote_amount         : arg10,
            meme_unallocated     : arg11,
            quote_unallocated    : arg12,
            treasury             : arg13,
            gas_reserve_amount   : arg14,
        };
        0x2::event::emit<RoundPublished<T0, T1>>(v0);
    }

    public(friend) fun vault_created<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u128, arg4: 0xd1499adfec9cea739c2fb58d4e870c997c9f5e56482a03edd31b76e82bf1b2a2::migration::VaultTerms, arg5: u64, arg6: u64) {
        let v0 = VaultCreated<T0, T1, T2>{
            vault_id              : arg0,
            pool_id               : arg1,
            position_id           : arg2,
            liquidity             : arg3,
            terms                 : arg4,
            residual_meme_amount  : arg5,
            residual_quote_amount : arg6,
        };
        0x2::event::emit<VaultCreated<T0, T1, T2>>(v0);
    }

    // decompiled from Move bytecode v7
}

