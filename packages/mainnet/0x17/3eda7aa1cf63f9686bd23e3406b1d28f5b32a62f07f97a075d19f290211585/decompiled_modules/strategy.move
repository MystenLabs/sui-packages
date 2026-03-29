module 0x173eda7aa1cf63f9686bd23e3406b1d28f5b32a62f07f97a075d19f290211585::strategy {
    struct YieldReceipt<phantom T0> {
        strategy_id: u8,
        asset_amount: u64,
    }

    struct ProtocolInfo has copy, drop, store {
        strategy_id: u8,
        name: 0x1::string::String,
        has_rewards: bool,
    }

    struct StrategyRegistry has key {
        id: 0x2::object::UID,
        protocols: 0x2::vec_map::VecMap<u8, ProtocolInfo>,
        protocol_access_cap: 0x1::option::Option<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap>,
    }

    struct ProtocolRegisteredEvent has copy, drop {
        strategy_id: u8,
        name: 0x1::string::String,
    }

    public fun borrow_for_reroute<T0>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>) : (0x2::balance::Balance<T0>, 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::BorrowReceipt<T0>) {
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::borrow_all_for_strategy<T0>(arg1, borrow_protocol_access_cap(arg0))
    }

    public(friend) fun borrow_protocol_access_cap(arg0: &StrategyRegistry) : &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap {
        0x1::option::borrow<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap>(&arg0.protocol_access_cap)
    }

    public fun count_available(arg0: &StrategyRegistry) : u64 {
        0x2::vec_map::length<u8, ProtocolInfo>(&arg0.protocols)
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyRegistry{
            id                  : 0x2::object::new(arg0),
            protocols           : 0x2::vec_map::empty<u8, ProtocolInfo>(),
            protocol_access_cap : 0x1::option::none<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap>(),
        };
        0x2::transfer::share_object<StrategyRegistry>(v0);
    }

    public fun create_yield_receipt<T0>(arg0: u8, arg1: u64) : YieldReceipt<T0> {
        YieldReceipt<T0>{
            strategy_id  : arg0,
            asset_amount : arg1,
        }
    }

    public fun decode_strategy(arg0: u8) : (u8, u8) {
        (arg0 >> 4, arg0 & 15)
    }

    public fun encode_strategy(arg0: u8, arg1: u8) : u8 {
        arg0 << 4 | arg1
    }

    public fun finish_reroute_usdc<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg2: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::BorrowReceipt<T0>, arg3: 0x2::balance::Balance<T1>, arg4: YieldReceipt<T1>) {
        let YieldReceipt {
            strategy_id  : v0,
            asset_amount : v1,
        } = arg4;
        let (_, v3) = decode_strategy(v0);
        assert!(v3 == 1, 405);
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::commit_strategy<T0, T1>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, v0, v1);
    }

    public fun finish_reroute_usdsui<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg2: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::BorrowReceipt<T0>, arg3: 0x2::balance::Balance<T1>, arg4: YieldReceipt<T1>, arg5: vector<u8>, arg6: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg7: &0x2::clock::Clock) {
        let YieldReceipt {
            strategy_id  : v0,
            asset_amount : v1,
        } = arg4;
        let (_, v3) = decode_strategy(v0);
        assert!(v3 == 2, 405);
        let v4 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_info_from_price_info_object(arg6);
        let v5 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_identifier(&v4);
        assert!(0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_identifier::get_bytes(&v5) == arg5, 404);
        let v6 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::pyth::get_price_no_older_than(arg6, arg7, 60);
        let v7 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_price(&v6);
        let v8 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_expo(&v6);
        let v9 = 1;
        let v10 = 0;
        while (v10 < 9) {
            v9 = v9 * 10;
            v10 = v10 + 1;
        };
        v10 = 0;
        while (v10 < 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_negative(&v8)) {
            v9 = v9 * 10;
            v10 = v10 + 1;
        };
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::commit_strategy<T0, T1>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, v0, (((v1 as u128) * (0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_positive(&v7) as u128) * 1000000 / v9) as u64));
    }

    public fun finish_withdraw<T0>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg2: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>) {
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::repay_withdraw<T0>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3);
    }

    public fun get_protocol_info(arg0: &StrategyRegistry, arg1: u8) : ProtocolInfo {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        *0x2::vec_map::get<u8, ProtocolInfo>(&arg0.protocols, &arg1)
    }

    public fun has_rewards(arg0: &StrategyRegistry, arg1: u8) : bool {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        0x2::vec_map::get<u8, ProtocolInfo>(&arg0.protocols, &arg1).has_rewards
    }

    public fun is_available(arg0: &StrategyRegistry, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1)
    }

    public fun issue_yield_promise_for_spoke<T0, T1>(arg0: &StrategyRegistry, arg1: &0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg2: u64) : 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::YieldPromise<T0> {
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::issue_yield_promise<T0, T1>(arg1, borrow_protocol_access_cap(arg0), arg2)
    }

    public fun list_available(arg0: &StrategyRegistry) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolInfo>(&arg0.protocols)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolInfo>(&arg0.protocols, v1);
            0x1::vector::push_back<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun name(arg0: &ProtocolInfo) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun register_protocol(arg0: &mut StrategyRegistry, arg1: u8, arg2: 0x1::string::String, arg3: bool) {
        assert!(arg1 != 0, 402);
        assert!(!0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 400);
        let v0 = ProtocolInfo{
            strategy_id : arg1,
            name        : arg2,
            has_rewards : arg3,
        };
        0x2::vec_map::insert<u8, ProtocolInfo>(&mut arg0.protocols, arg1, v0);
        let v1 = ProtocolRegisteredEvent{
            strategy_id : arg1,
            name        : arg2,
        };
        0x2::event::emit<ProtocolRegisteredEvent>(v1);
    }

    public fun repay_promise_usdc<T0>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg2: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::YieldPromise<T0>, arg3: 0x2::coin::Coin<T0>) {
        assert!(0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::promise_type<T0>(&arg2) == 0x1::type_name::with_defining_ids<T0>(), 999);
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::commit_unwind<T0>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::promise_expected<T0>(&arg2));
    }

    public fun repay_promise_usdsui<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>, arg2: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::YieldPromise<T0>, arg3: 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: &0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::PriceInfoObject, arg6: &0x2::clock::Clock) {
        assert!(0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::promise_type<T0>(&arg2) == 0x1::type_name::with_defining_ids<T1>(), 999);
        let v0 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_info_from_price_info_object(arg5);
        let v1 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_info::get_price_identifier(&v0);
        assert!(0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price_identifier::get_bytes(&v1) == arg4, 404);
        let v2 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::pyth::get_price_no_older_than(arg5, arg6, 60);
        let v3 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_price(&v2);
        let v4 = 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::price::get_expo(&v2);
        let v5 = 1;
        let v6 = 0;
        while (v6 < 9) {
            v5 = v5 * 10;
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_negative(&v4)) {
            v5 = v5 * 10;
            v6 = v6 + 1;
        };
        0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::commit_unwind<T0>(arg1, borrow_protocol_access_cap(arg0), arg2, arg3, (((0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::promise_expected<T0>(&arg2) as u128) * (0xcd90be8978b6ba0a88cc48270cf6de0bd4b0fae1ac8877c641243844dbabd215::i64::get_magnitude_if_positive(&v3) as u128) * 1000000 / v5) as u64));
    }

    public(friend) fun set_protocol_access_cap(arg0: &mut StrategyRegistry, arg1: 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap) {
        0x1::option::fill<0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::ProtocolAccessCap>(&mut arg0.protocol_access_cap, arg1);
    }

    public fun stable_usdc() : u8 {
        1
    }

    public fun stable_usdsui() : u8 {
        2
    }

    public(friend) fun update_has_rewards(arg0: &mut StrategyRegistry, arg1: u8, arg2: bool) {
        assert!(0x2::vec_map::contains<u8, ProtocolInfo>(&arg0.protocols, &arg1), 401);
        0x2::vec_map::get_mut<u8, ProtocolInfo>(&mut arg0.protocols, &arg1).has_rewards = arg2;
    }

    public fun withdraw_yield_for_spoke<T0, T1>(arg0: &StrategyRegistry, arg1: &mut 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::Vault<T0>) : (0x2::balance::Balance<T1>, 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::YieldPromise<T0>) {
        let v0 = borrow_protocol_access_cap(arg0);
        (0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::take_yield_balance<T0, T1>(arg1, v0), 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::issue_yield_promise<T0, T1>(arg1, v0, 0x6f8d1d25f7a66d967e92fed17d6a362055d3544b6218dc606c1cbc70bfc55f5f::vault::last_deployed_amount<T0>(arg1)))
    }

    // decompiled from Move bytecode v6
}

