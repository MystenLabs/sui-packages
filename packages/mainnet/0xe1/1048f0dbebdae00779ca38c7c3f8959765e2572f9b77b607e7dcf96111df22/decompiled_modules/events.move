module 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::events {
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

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        issuer: address,
        referrer: 0x1::option::Option<address>,
        types: vector<0x1::ascii::String>,
        withdrawn: vector<u64>,
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

    public(friend) fun emit_created_pool_event<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>) {
        let v0 = CreatedPoolEvent{
            pool_id       : 0x2::object::id<0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>>(arg0),
            name          : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::name<T0>(arg0),
            creator       : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::creator<T0>(arg0),
            lp_type       : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::lp_type<T0>(arg0),
            coins         : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::type_names<T0>(arg0),
            weights       : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::weights<T0>(arg0),
            flatness      : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::flatness<T0>(arg0),
            fees_swap_in  : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_in<T0>(arg0),
            fees_swap_out : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_swap_out<T0>(arg0),
            fees_deposit  : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_deposit<T0>(arg0),
            fees_withdraw : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::fees_withdraw<T0>(arg0),
        };
        0x2::event::emit<CreatedPoolEvent>(v0);
    }

    public(friend) fun emit_deposit_event<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: u64) {
        let v0 = DepositEvent{
            pool_id         : 0x2::object::id<0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>>(arg0),
            issuer          : arg1,
            referrer        : arg2,
            types           : arg3,
            deposits        : arg4,
            lp_coins_minted : arg5,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public(friend) fun emit_oracle_price_event<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: u128) {
        let v0 = OraclePriceEvent{
            pool_id      : 0x2::object::id<0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>>(arg0),
            base_type    : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>(),
            quote_type   : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>(),
            oracle_price : arg1,
        };
        0x2::event::emit<OraclePriceEvent>(v0);
    }

    public(friend) fun emit_spot_price_event<T0, T1, T2>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: u128) {
        let v0 = SpotPriceEvent{
            pool_id    : 0x2::object::id<0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>>(arg0),
            base_type  : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T1>(),
            quote_type : 0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::keys::type_to_string<T2>(),
            spot_price : arg1,
        };
        0x2::event::emit<SpotPriceEvent>(v0);
    }

    public(friend) fun emit_swap_event<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: vector<0x1::ascii::String>, arg6: vector<u64>) {
        let v0 = SwapEvent{
            pool_id     : 0x2::object::id<0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>>(arg0),
            issuer      : arg1,
            referrer    : arg2,
            types_in    : arg3,
            amounts_in  : arg4,
            types_out   : arg5,
            amounts_out : arg6,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public(friend) fun emit_withdraw_event<T0>(arg0: &0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: vector<0x1::ascii::String>, arg4: vector<u64>, arg5: u64) {
        let v0 = WithdrawEvent{
            pool_id         : 0x2::object::id<0xe11048f0dbebdae00779ca38c7c3f8959765e2572f9b77b607e7dcf96111df22::pool::Pool<T0>>(arg0),
            issuer          : arg1,
            referrer        : arg2,
            types           : arg3,
            withdrawn       : arg4,
            lp_coins_burned : arg5,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

