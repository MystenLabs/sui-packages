module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::launchpad {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        protocol_fee_bps: u64,
        creator_fee_bps: u64,
        graduation_sui_threshold: u64,
        curve_token_supply: u64,
        curve_sale_token_supply: u64,
        migration_token_supply: u64,
        virtual_sui_reserve: u64,
        virtual_token_reserve: u64,
        paused: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        protocol_fee_bps: u64,
        creator_fee_bps: u64,
        reward_policy: 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards::Policy,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        token_reserve: 0x2::balance::Balance<T0>,
        migration_token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_reserve: u64,
        virtual_token_reserve: u64,
        token_supply: u64,
        total_sold: u64,
        total_volume_sui: u64,
        graduated: bool,
        migration_started: bool,
        migrated_sui: u64,
        migrated_tokens: u64,
        dex_pool_id: 0x1::option::Option<0x2::object::ID>,
        liquidity_position_id: 0x1::option::Option<0x2::object::ID>,
        metadata_id: 0x2::object::ID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        website: 0x1::string::String,
        x: 0x1::string::String,
        telegram: 0x1::string::String,
        created_at_ms: u64,
        decimals: u8,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        metadata_id: 0x2::object::ID,
        supply: u64,
        created_at_ms: u64,
    }

    struct RewardPolicyCreated has copy, drop {
        curve_id: 0x2::object::ID,
        protocol_fee_bps: u64,
        creator_fee_bps: u64,
    }

    struct TradeEvent has copy, drop {
        curve_id: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        protocol_fee_sui: u64,
        creator_fee_sui: u64,
    }

    struct GraduationEvent has copy, drop {
        curve_id: 0x2::object::ID,
        sui_reserve: u64,
        token_reserve: u64,
        migration_token_reserve: u64,
    }

    struct MigrationPreparedEvent has copy, drop {
        curve_id: 0x2::object::ID,
        sui_amount: u64,
        token_amount: u64,
    }

    struct MigrationFinalizedEvent has copy, drop {
        curve_id: 0x2::object::ID,
        dex_pool_id: 0x2::object::ID,
        liquidity_position_id: 0x2::object::ID,
    }

    public(friend) fun begin_cetus_migration<T0>(arg0: &Config, arg1: &mut Curve<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>, u128, u128) {
        assert!(!arg0.paused, 2);
        assert!(arg1.graduated, 8);
        assert!(!arg1.migration_started && 0x1::option::is_none<0x2::object::ID>(&arg1.dex_pool_id), 15);
        0x2::balance::join<T0>(&mut arg1.migration_token_reserve, 0x2::balance::withdraw_all<T0>(&mut arg1.token_reserve));
        arg1.migrated_sui = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve);
        arg1.migrated_tokens = 0x2::balance::value<T0>(&arg1.migration_token_reserve);
        assert!(arg1.migrated_sui > 0 && arg1.migrated_tokens > 0, 9);
        arg1.migration_started = true;
        let v0 = MigrationPreparedEvent{
            curve_id     : 0x2::object::id<Curve<T0>>(arg1),
            sui_amount   : arg1.migrated_sui,
            token_amount : arg1.migrated_tokens,
        };
        0x2::event::emit<MigrationPreparedEvent>(v0);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.sui_reserve), arg2), 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.migration_token_reserve), arg2), (0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) as u128) + (arg1.virtual_sui_reserve as u128), (0x2::balance::value<T0>(&arg1.token_reserve) as u128) + (arg1.virtual_token_reserve as u128))
    }

    public fun buy<T0>(arg0: &Config, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(!arg1.graduated, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = quote_buy_amount(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve), 0x2::balance::value<T0>(&arg1.token_reserve), arg1.virtual_sui_reserve, arg1.virtual_token_reserve, net_amount_after_fees(v0, arg1.protocol_fee_bps, arg1.creator_fee_bps));
        assert!(v1 > 0, 9);
        assert!(v1 >= arg3, 5);
        let v2 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        let v3 = &mut v2;
        let v4 = split_fee(v3, arg1.protocol_fee_bps, v0, arg0.treasury, arg4);
        let v5 = mul_div(v0, arg1.creator_fee_bps, 10000);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards::distribute(&mut arg1.reward_policy, 0x2::object::id<Curve<T0>>(arg1), 0x2::balance::split<0x2::sui::SUI>(&mut v2, v5), arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.token_reserve, v1), arg4), 0x2::tx_context::sender(arg4));
        arg1.total_sold = arg1.total_sold + v1;
        arg1.total_volume_sui = arg1.total_volume_sui + v0;
        let v6 = TradeEvent{
            curve_id         : 0x2::object::id<Curve<T0>>(arg1),
            trader           : 0x2::tx_context::sender(arg4),
            is_buy           : true,
            sui_amount       : 0x2::balance::value<0x2::sui::SUI>(&v2),
            token_amount     : v1,
            protocol_fee_sui : v4,
            creator_fee_sui  : v5,
        };
        0x2::event::emit<TradeEvent>(v6);
        maybe_mark_graduated<T0>(arg0, arg1);
    }

    public(friend) fun complete_cetus_migration<T0>(arg0: &mut Curve<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        assert!(arg0.migration_started && 0x1::option::is_none<0x2::object::ID>(&arg0.dex_pool_id), 15);
        arg0.dex_pool_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.liquidity_position_id = 0x1::option::some<0x2::object::ID>(arg2);
        let v0 = MigrationFinalizedEvent{
            curve_id              : 0x2::object::id<Curve<T0>>(arg0),
            dex_pool_id           : arg1,
            liquidity_position_id : arg2,
        };
        0x2::event::emit<MigrationFinalizedEvent>(v0);
    }

    public fun finalize_migration<T0>(arg0: &Config, arg1: &AdminCap, arg2: &mut Curve<T0>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        abort 15
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id                       : 0x2::object::new(arg0),
            admin                    : v0,
            treasury                 : v0,
            protocol_fee_bps         : 75,
            creator_fee_bps          : 50,
            graduation_sui_threshold : 1000000000,
            curve_token_supply       : 1000000000000000,
            curve_sale_token_supply  : 793100000000000,
            migration_token_supply   : 206900000000000,
            virtual_sui_reserve      : 352941177,
            virtual_token_reserve    : 279900000000000,
            paused                   : false,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun initialize_curve<T0>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u8, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg13));
        initialize_curve_with_rewards<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v0, vector[10000], arg13);
    }

    public fun initialize_curve_with_rewards<T0>(arg0: &Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::CoinMetadata<T0>, arg3: &0x2::clock::Clock, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u8, arg12: u64, arg13: vector<address>, arg14: vector<u64>, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg12 <= 0, 7);
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = mul_div(arg0.curve_token_supply, arg12, 10000);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(&mut arg1, v1, arg15), v0);
        };
        let v2 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&arg2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(arg2);
        let v3 = Curve<T0>{
            id                      : 0x2::object::new(arg15),
            creator                 : v0,
            protocol_fee_bps        : arg0.protocol_fee_bps,
            creator_fee_bps         : arg0.creator_fee_bps,
            reward_policy           : 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards::create(arg13, arg14),
            treasury_cap            : arg1,
            token_reserve           : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.curve_sale_token_supply, arg15)),
            migration_token_reserve : 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg1, arg0.migration_token_supply - v1, arg15)),
            sui_reserve             : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_reserve     : arg0.virtual_sui_reserve,
            virtual_token_reserve   : arg0.virtual_token_reserve,
            token_supply            : arg0.curve_token_supply,
            total_sold              : 0,
            total_volume_sui        : 0,
            graduated               : false,
            migration_started       : false,
            migrated_sui            : 0,
            migrated_tokens         : 0,
            dex_pool_id             : 0x1::option::none<0x2::object::ID>(),
            liquidity_position_id   : 0x1::option::none<0x2::object::ID>(),
            metadata_id             : v2,
            name                    : arg4,
            symbol                  : arg5,
            description             : arg6,
            image_url               : arg7,
            website                 : arg8,
            x                       : arg9,
            telegram                : arg10,
            created_at_ms           : 0x2::clock::timestamp_ms(arg3),
            decimals                : arg11,
        };
        let v4 = 0x2::object::id<Curve<T0>>(&v3);
        let v5 = RewardPolicyCreated{
            curve_id         : v4,
            protocol_fee_bps : v3.protocol_fee_bps,
            creator_fee_bps  : v3.creator_fee_bps,
        };
        0x2::event::emit<RewardPolicyCreated>(v5);
        0x2::transfer::share_object<Curve<T0>>(v3);
        let v6 = CurveCreated{
            curve_id      : v4,
            creator       : v0,
            metadata_id   : v2,
            supply        : arg0.curve_token_supply,
            created_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CurveCreated>(v6);
    }

    public fun is_graduated<T0>(arg0: &Curve<T0>) : bool {
        arg0.graduated
    }

    public fun is_migrated<T0>(arg0: &Curve<T0>) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.dex_pool_id)
    }

    public fun is_migration_started<T0>(arg0: &Curve<T0>) : bool {
        arg0.migration_started
    }

    public fun mark_graduated<T0>(arg0: &Config, arg1: &mut Curve<T0>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) >= arg0.graduation_sui_threshold, 8);
        assert!(!arg1.graduated, 3);
        arg1.graduated = true;
        let v0 = GraduationEvent{
            curve_id                : 0x2::object::id<Curve<T0>>(arg1),
            sui_reserve             : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve),
            token_reserve           : 0x2::balance::value<T0>(&arg1.token_reserve),
            migration_token_reserve : 0x2::balance::value<T0>(&arg1.migration_token_reserve),
        };
        0x2::event::emit<GraduationEvent>(v0);
    }

    fun maybe_mark_graduated<T0>(arg0: &Config, arg1: &mut Curve<T0>) {
        if (!arg1.graduated && 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve) >= arg0.graduation_sui_threshold) {
            arg1.graduated = true;
            let v0 = GraduationEvent{
                curve_id                : 0x2::object::id<Curve<T0>>(arg1),
                sui_reserve             : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve),
                token_reserve           : 0x2::balance::value<T0>(&arg1.token_reserve),
                migration_token_reserve : 0x2::balance::value<T0>(&arg1.migration_token_reserve),
            };
            0x2::event::emit<GraduationEvent>(v0);
        };
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun net_amount_after_fees(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 - mul_div(arg0, arg1, 10000) - mul_div(arg0, arg2, 10000)
    }

    public fun prepare_migration<T0>(arg0: &Config, arg1: &AdminCap, arg2: &mut Curve<T0>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        abort 15
    }

    public fun quote_buy<T0>(arg0: &Config, arg1: &Curve<T0>, arg2: u64) : u64 {
        quote_buy_amount(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve), 0x2::balance::value<T0>(&arg1.token_reserve), arg1.virtual_sui_reserve, arg1.virtual_token_reserve, net_amount_after_fees(arg2, arg1.protocol_fee_bps, arg1.creator_fee_bps))
    }

    fun quote_buy_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg4 > 0, 4);
        let v0 = (arg0 as u128) + (arg2 as u128);
        let v1 = (arg1 as u128) + (arg3 as u128);
        let v2 = v1 - v0 * v1 / (v0 + (arg4 as u128));
        if (v2 > (arg1 as u128)) {
            arg1
        } else {
            (v2 as u64)
        }
    }

    public fun quote_sell<T0>(arg0: &Config, arg1: &Curve<T0>, arg2: u64) : u64 {
        net_amount_after_fees(quote_sell_amount(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve), 0x2::balance::value<T0>(&arg1.token_reserve), arg1.virtual_sui_reserve, arg1.virtual_token_reserve, arg2), arg1.protocol_fee_bps, arg1.creator_fee_bps)
    }

    fun quote_sell_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg4 > 0, 4);
        let v0 = (arg0 as u128) + (arg2 as u128);
        let v1 = (arg1 as u128) + (arg3 as u128);
        let v2 = v0 - v0 * v1 / (v1 + (arg4 as u128));
        if (v2 > (arg0 as u128)) {
            arg0
        } else {
            (v2 as u64)
        }
    }

    public fun sell<T0>(arg0: &Config, arg1: &mut Curve<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(!arg1.graduated, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 4);
        let v1 = quote_sell_amount(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reserve), 0x2::balance::value<T0>(&arg1.token_reserve), arg1.virtual_sui_reserve, arg1.virtual_token_reserve, v0);
        assert!(v1 > 0, 9);
        let v2 = mul_div(v1, arg1.protocol_fee_bps, 10000);
        let v3 = mul_div(v1, arg1.creator_fee_bps, 10000);
        let v4 = v1 - v2 - v3;
        assert!(v4 > 0, 9);
        assert!(v4 >= arg3, 5);
        0x2::balance::join<T0>(&mut arg1.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v2), arg4), arg0.treasury);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards::distribute(&mut arg1.reward_policy, 0x2::object::id<Curve<T0>>(arg1), 0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v3), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reserve, v4), arg4), 0x2::tx_context::sender(arg4));
        let v5 = if (v0 >= arg1.total_sold) {
            0
        } else {
            arg1.total_sold - v0
        };
        arg1.total_sold = v5;
        arg1.total_volume_sui = arg1.total_volume_sui + v1;
        let v6 = TradeEvent{
            curve_id         : 0x2::object::id<Curve<T0>>(arg1),
            trader           : 0x2::tx_context::sender(arg4),
            is_buy           : false,
            sui_amount       : v4,
            token_amount     : v0,
            protocol_fee_sui : v2,
            creator_fee_sui  : v3,
        };
        0x2::event::emit<TradeEvent>(v6);
    }

    public fun settle_cetus_fees<T0>(arg0: &Config, arg1: &mut Curve<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 2);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.dex_pool_id), 14);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg1.dex_pool_id) == arg2, 14);
        assert!(arg1.protocol_fee_bps == arg4 && arg1.creator_fee_bps == arg5, 13);
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::routed_fees::settle(0x2::object::id<Curve<T0>>(arg1), arg2, &mut arg1.reward_policy, arg0.treasury, arg1.protocol_fee_bps, arg1.creator_fee_bps, arg3, arg6, arg7)
    }

    fun split_fee(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = mul_div(arg2, arg1, 10000);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(arg0, v0), arg4), arg3);
        };
        v0
    }

    public fun update_config(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 + arg4 <= 500, 6);
        arg0.admin = 0x2::tx_context::sender(arg7);
        arg0.treasury = arg2;
        arg0.protocol_fee_bps = arg3;
        arg0.creator_fee_bps = arg4;
        arg0.graduation_sui_threshold = arg5;
        arg0.paused = arg6;
    }

    // decompiled from Move bytecode v7
}

