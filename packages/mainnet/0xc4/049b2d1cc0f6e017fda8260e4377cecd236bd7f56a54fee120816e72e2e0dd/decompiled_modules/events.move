module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::events {
    struct CreatedPoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
        lp_type: 0x1::ascii::String,
        coins: vector<0x1::ascii::String>,
        weights: vector<u64>,
        flatness: u64,
        fees_swap_in: vector<u64>,
        fees_swap_out: vector<u64>,
        fees_deposit: vector<u64>,
        fees_withdraw: vector<u64>,
    }

    struct OraclePriceEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        oracle_price: u128,
    }

    struct SpotPriceEvent has copy, drop {
        pool_id: 0x2::object::ID,
        base_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        spot_price: u128,
    }

    struct DepositEvent has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types: vector<0x1::ascii::String>,
        deposits: vector<u64>,
        lp_coins_minted: u64,
    }

    struct DepositEventV2 has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types: vector<0x1::ascii::String>,
        deposits: vector<u64>,
        reserves: vector<u64>,
        lp_coins_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types: vector<0x1::ascii::String>,
        withdrawn: vector<u64>,
        lp_coins_burned: u64,
    }

    struct WithdrawEventV2 has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types: vector<0x1::ascii::String>,
        withdrawn: vector<u64>,
        reserves: vector<u64>,
        lp_coins_burned: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types_in: vector<0x1::ascii::String>,
        amounts_in: vector<u64>,
        types_out: vector<0x1::ascii::String>,
        amounts_out: vector<u64>,
    }

    struct SwapEventV2 has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types_in: vector<0x1::ascii::String>,
        amounts_in: vector<u64>,
        types_out: vector<0x1::ascii::String>,
        amounts_out: vector<u64>,
        reserves: vector<u64>,
    }

    public(friend) fun emit_created_pool_event<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>) {
        let v0 = CreatedPoolEvent{
            pool_id       : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            name          : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::name<T0>(arg0),
            creator       : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::creator<T0>(arg0),
            lp_type       : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::lp_type<T0>(arg0),
            coins         : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::type_names<T0>(arg0),
            weights       : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::weights<T0>(arg0),
            flatness      : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::flatness<T0>(arg0),
            fees_swap_in  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_in<T0>(arg0),
            fees_swap_out : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_swap_out<T0>(arg0),
            fees_deposit  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_deposit<T0>(arg0),
            fees_withdraw : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::fees_withdraw<T0>(arg0),
        };
        0x2::event::emit<CreatedPoolEvent>(v0);
    }

    public(friend) fun emit_deposit_event<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64) {
        let v0 = DepositEventV2{
            pool_id         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            issuer          : arg1,
            referrer        : arg2,
            types           : arg3,
            deposits        : arg4,
            reserves        : arg5,
            lp_coins_minted : arg6,
        };
        0x2::event::emit<DepositEventV2>(v0);
    }

    public(friend) fun emit_oracle_price_event<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u128) {
        let v0 = OraclePriceEvent{
            pool_id      : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            base_type    : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>(),
            quote_type   : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>(),
            oracle_price : arg1,
        };
        0x2::event::emit<OraclePriceEvent>(v0);
    }

    public(friend) fun emit_spot_price_event<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u128) {
        let v0 = SpotPriceEvent{
            pool_id    : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            base_type  : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>(),
            quote_type : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T2>(),
            spot_price : arg1,
        };
        0x2::event::emit<SpotPriceEvent>(v0);
    }

    public(friend) fun emit_swap_event<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<0x1::ascii::String>, arg6: vector<u64>, arg7: vector<u64>) {
        let v0 = SwapEventV2{
            pool_id     : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            issuer      : arg1,
            referrer    : arg2,
            types_in    : arg3,
            amounts_in  : arg4,
            types_out   : arg5,
            amounts_out : arg6,
            reserves    : arg7,
        };
        0x2::event::emit<SwapEventV2>(v0);
    }

    public(friend) fun emit_withdraw_event<T0>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64) {
        let v0 = WithdrawEventV2{
            pool_id         : 0x2::object::id<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>>(arg0),
            issuer          : arg1,
            referrer        : arg2,
            types           : arg3,
            withdrawn       : arg4,
            reserves        : arg5,
            lp_coins_burned : arg6,
        };
        0x2::event::emit<WithdrawEventV2>(v0);
    }

    // decompiled from Move bytecode v6
}

