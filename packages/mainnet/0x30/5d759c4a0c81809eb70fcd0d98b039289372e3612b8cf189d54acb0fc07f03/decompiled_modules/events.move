module 0x2b79fe248bbd7d32de2a967bddad9ddfc6857016e4b768038c04e65b3e7eae0::events {
    struct TokenCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        creator: address,
        decimals: u8,
        total_supply: u64,
        curve_supply: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
        website: 0x1::string::String,
        twitter: 0x1::string::String,
        telegram: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct Trade has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        fee_amount: u64,
        sui_reserve: u64,
        token_reserve: u64,
        curve_remaining: u64,
        price_scaled: u128,
        progress_bps: u64,
        referrer: 0x1::option::Option<address>,
        timestamp_ms: u64,
    }

    struct FeesClaimed has copy, drop {
        claimer: address,
        kind: 0x1::ascii::String,
        curve_id: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
        timestamp_ms: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        vault_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
        migration_fee: u64,
        final_price_scaled: u128,
        timestamp_ms: u64,
    }

    struct Migrated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_burn_proof: 0x1::option::Option<0x2::object::ID>,
        sui_amount: u64,
        token_amount: u64,
        timestamp_ms: u64,
    }

    struct ReferralBound has copy, drop {
        trader: address,
        referrer: address,
        timestamp_ms: u64,
    }

    struct PostGraduationFees has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        sui_amount: u64,
        token_amount: u64,
        timestamp_ms: u64,
    }

    struct LimitPlaced has copy, drop {
        order_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        owner: address,
        is_buy: bool,
        amount: u64,
        trigger_price: u128,
        above: bool,
        min_out: u64,
        expires_at_ms: u64,
        timestamp_ms: u64,
    }

    struct LimitFilled has copy, drop {
        order_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        filler: address,
        is_buy: bool,
        received: u64,
        price_scaled: u128,
        timestamp_ms: u64,
    }

    struct LimitCancelled has copy, drop {
        order_id: 0x2::object::ID,
        curve_id: 0x2::object::ID,
        owner: address,
        expired: bool,
        refunded: u64,
        timestamp_ms: u64,
    }

    public(friend) fun fees_claimed(arg0: address, arg1: 0x1::ascii::String, arg2: 0x1::option::Option<0x2::object::ID>, arg3: u64, arg4: u64) {
        let v0 = FeesClaimed{
            claimer      : arg0,
            kind         : arg1,
            curve_id     : arg2,
            amount       : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<FeesClaimed>(v0);
    }

    public(friend) fun graduated(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u64) {
        let v0 = Graduated{
            curve_id           : arg0,
            coin_type          : arg1,
            vault_id           : arg2,
            sui_amount         : arg3,
            token_amount       : arg4,
            migration_fee      : arg5,
            final_price_scaled : arg6,
            timestamp_ms       : arg7,
        };
        0x2::event::emit<Graduated>(v0);
    }

    public(friend) fun limit_cancelled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u64) {
        let v0 = LimitCancelled{
            order_id     : arg0,
            curve_id     : arg1,
            owner        : arg2,
            expired      : arg3,
            refunded     : arg4,
            timestamp_ms : arg5,
        };
        0x2::event::emit<LimitCancelled>(v0);
    }

    public(friend) fun limit_filled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: address, arg4: bool, arg5: u64, arg6: u128, arg7: u64) {
        let v0 = LimitFilled{
            order_id     : arg0,
            curve_id     : arg1,
            owner        : arg2,
            filler       : arg3,
            is_buy       : arg4,
            received     : arg5,
            price_scaled : arg6,
            timestamp_ms : arg7,
        };
        0x2::event::emit<LimitFilled>(v0);
    }

    public(friend) fun limit_placed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: address, arg4: bool, arg5: u64, arg6: u128, arg7: bool, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = LimitPlaced{
            order_id      : arg0,
            curve_id      : arg1,
            coin_type     : arg2,
            owner         : arg3,
            is_buy        : arg4,
            amount        : arg5,
            trigger_price : arg6,
            above         : arg7,
            min_out       : arg8,
            expires_at_ms : arg9,
            timestamp_ms  : arg10,
        };
        0x2::event::emit<LimitPlaced>(v0);
    }

    public(friend) fun migrated(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = Migrated{
            curve_id      : arg0,
            coin_type     : arg1,
            vault_id      : arg2,
            pool_id       : arg3,
            lp_burn_proof : arg4,
            sui_amount    : arg5,
            token_amount  : arg6,
            timestamp_ms  : arg7,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun new_token_created(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: 0x1::string::String, arg13: 0x1::string::String, arg14: 0x1::string::String, arg15: u64) : TokenCreated {
        TokenCreated{
            curve_id       : arg0,
            coin_type      : arg1,
            name           : arg2,
            symbol         : arg3,
            description    : arg4,
            icon_url       : arg5,
            creator        : arg6,
            decimals       : arg7,
            total_supply   : arg8,
            curve_supply   : arg9,
            virtual_sui    : arg10,
            virtual_tokens : arg11,
            website        : arg12,
            twitter        : arg13,
            telegram       : arg14,
            timestamp_ms   : arg15,
        }
    }

    public(friend) fun post_graduation_fees(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PostGraduationFees{
            curve_id     : arg0,
            coin_type    : arg1,
            sui_amount   : arg2,
            token_amount : arg3,
            timestamp_ms : arg4,
        };
        0x2::event::emit<PostGraduationFees>(v0);
    }

    public(friend) fun referral_bound(arg0: address, arg1: address, arg2: u64) {
        let v0 = ReferralBound{
            trader       : arg0,
            referrer     : arg1,
            timestamp_ms : arg2,
        };
        0x2::event::emit<ReferralBound>(v0);
    }

    public(friend) fun token_created(arg0: TokenCreated) {
        0x2::event::emit<TokenCreated>(arg0);
    }

    public(friend) fun trade(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u64, arg12: 0x1::option::Option<address>, arg13: u64) {
        let v0 = Trade{
            curve_id        : arg0,
            coin_type       : arg1,
            trader          : arg2,
            is_buy          : arg3,
            sui_amount      : arg4,
            token_amount    : arg5,
            fee_amount      : arg6,
            sui_reserve     : arg7,
            token_reserve   : arg8,
            curve_remaining : arg9,
            price_scaled    : arg10,
            progress_bps    : arg11,
            referrer        : arg12,
            timestamp_ms    : arg13,
        };
        0x2::event::emit<Trade>(v0);
    }

    // decompiled from Move bytecode v7
}

