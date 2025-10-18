module 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_market {
    struct Market has store, key {
        id: 0x2::object::UID,
        market_number: u64,
        creator: address,
        question: 0x1::string::String,
        options: vector<0x2::object::ID>,
        coin_type: 0x1::type_name::TypeName,
        start_time: u64,
        end_time: u64,
        base_fee_rate: u64,
        platform_fee_rate: u64,
        creator_fee_rate: u64,
        ref_fee_rate: u64,
        resolver_collateral: u64,
        timestamp: u64,
    }

    struct MarketCreated has copy, drop {
        id: 0x2::object::ID,
        market_number: u64,
        creator: address,
        question: 0x1::string::String,
        options: vector<0x2::object::ID>,
        coin_type: 0x1::type_name::TypeName,
        start_time: u64,
        end_time: u64,
        base_fee_rate: u64,
        platform_fee_rate: u64,
        creator_fee_rate: u64,
        ref_fee_rate: u64,
        resolver_collateral: u64,
        timestamp: u64,
    }

    public fun cancel_order(arg0: u128, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::order::emit_order_canceled(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8));
    }

    public fun create_market<T0>(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = Market{
            id                  : 0x2::object::new(arg5),
            market_number       : arg0,
            creator             : 0x2::tx_context::sender(arg5),
            question            : arg1,
            options             : 0x1::vector::empty<0x2::object::ID>(),
            coin_type           : 0x1::type_name::with_defining_ids<T0>(),
            start_time          : arg2,
            end_time            : arg3,
            base_fee_rate       : 10000,
            platform_fee_rate   : 600,
            creator_fee_rate    : 250,
            ref_fee_rate        : 150,
            resolver_collateral : 750,
            timestamp           : v0,
        };
        let v2 = 0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_option::create_option(0x2::object::id<Market>(&v1), arg1, 0, 3, v0, arg5);
        0x1::vector::push_back<0x2::object::ID>(&mut v1.options, 0x2::object::id<0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_option::PredOption>(&v2));
        0x2::transfer::public_share_object<0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_option::PredOption>(v2);
        emit_market_created(&v1);
        0x2::transfer::share_object<Market>(v1);
    }

    public fun emit_market_created(arg0: &Market) {
        let v0 = MarketCreated{
            id                  : 0x2::object::id<Market>(arg0),
            market_number       : arg0.market_number,
            creator             : arg0.creator,
            question            : arg0.question,
            options             : arg0.options,
            coin_type           : arg0.coin_type,
            start_time          : arg0.start_time,
            end_time            : arg0.end_time,
            base_fee_rate       : arg0.base_fee_rate,
            platform_fee_rate   : arg0.platform_fee_rate,
            creator_fee_rate    : arg0.creator_fee_rate,
            ref_fee_rate        : arg0.ref_fee_rate,
            resolver_collateral : arg0.resolver_collateral,
            timestamp           : arg0.timestamp,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public fun end_option(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_option::emit_option_ended(arg0, arg1, 0x1::option::some<u8>(arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun fill_order(arg0: 0x2::object::ID, arg1: u128, arg2: u128, arg3: address, arg4: address, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u8, arg15: u64, arg16: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::order_info::emit_order_filled(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x2::clock::timestamp_ms(arg16));
    }

    public fun place_order(arg0: u128, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u8, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::order_info::emit_order_placed(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::tx_context::epoch(arg10), arg8, 0x2::clock::timestamp_ms(arg9));
    }

    public fun resolution_disputer_submit(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u8, arg5: u64, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x1::option::Option<0x1::string::String>, arg8: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::resolutions::emit_disputer_propose_answer(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8));
    }

    public fun resolution_resolver_submit(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u8, arg5: u64, arg6: 0x1::option::Option<0x2::url::Url>, arg7: 0x1::option::Option<0x1::string::String>, arg8: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::resolutions::emit_resolver_propose_answer(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8));
    }

    public fun resolution_update(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u8, arg4: 0x1::option::Option<u8>, arg5: 0x1::option::Option<u8>, arg6: 0x1::option::Option<u64>, arg7: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::resolutions::emit_resolution_state_changed(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun reward_claim(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) {
        0xae1790d1e26f08455888c0a80c719b1ab294fe25847a6f3c4cc4e731f43866ed::pred_option::emit_reward_claimed(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5));
    }

    // decompiled from Move bytecode v6
}

