module 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::curve {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        treasury: 0x2::coin::TreasuryCap<T0>,
        pool_creation_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
        token_reserve: 0x2::balance::Balance<T0>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui: u64,
        virtual_tokens: u64,
        tokens_sold: u64,
        curve_supply: u64,
        trade_fee_bps: u64,
        creator_fee_bps: u64,
        graduation_fee_bps: u64,
        tick_spacing: u32,
        complete: bool,
        graduated: bool,
        pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct CurveCreated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        virtual_sui: u64,
        virtual_tokens: u64,
        curve_supply: u64,
        total_supply: u64,
        trade_fee_bps: u64,
        creator_fee_bps: u64,
        timestamp_ms: u64,
    }

    struct Trade has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        trader: address,
        is_buy: bool,
        sui_amount: u64,
        token_amount: u64,
        creator_fee: u64,
        platform_fee: u64,
        virtual_sui: u64,
        virtual_tokens: u64,
        tokens_sold: u64,
        sui_reserve: u64,
        timestamp_ms: u64,
    }

    struct CurveCompleted has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        sui_reserve: u64,
        timestamp_ms: u64,
    }

    struct Graduated has copy, drop {
        curve_id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        pool_id: 0x2::object::ID,
        sui_liquidity: u64,
        token_liquidity: u64,
        tokens_burned: u64,
        graduation_fee: u64,
        lp_proof_recipient: address,
        timestamp_ms: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct PlatformFeesClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        amount: u64,
    }

    public fun total_supply<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury)
    }

    public fun pool_id<T0>(arg0: &BondingCurve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun curve_supply<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.curve_supply
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        buy_as<T0>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6)
    }

    public(friend) fun buy_as<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_version(arg1);
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_not_paused(arg1);
        assert!(!arg0.complete, 103);
        assert!(arg3 > 0, 106);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg3, 109);
        let v0 = arg0.trade_fee_bps;
        let v1 = arg3;
        let v2 = mul_div_up(arg3, v0, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps());
        let v3 = v2;
        let v4 = arg3 - v2;
        let v5 = v4;
        let v6 = mul_div(arg0.virtual_tokens, v4, arg0.virtual_sui + v4);
        let v7 = v6;
        let v8 = arg0.curve_supply - arg0.tokens_sold;
        if (v6 >= v8) {
            v7 = v8;
            let v9 = mul_div_up(arg0.virtual_sui, v8, arg0.virtual_tokens - v8);
            v5 = v9;
            let v10 = mul_div_up(v9, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps(), 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps() - v0);
            v1 = v10;
            if (v10 > arg3) {
                v1 = arg3;
            };
            v3 = v1 - v9;
        };
        assert!(v7 > 0, 106);
        assert!(v7 >= arg4, 107);
        let v11 = 0x1::u64::min(mul_div(v1, arg0.creator_fee_bps, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps()), v3);
        let v12 = v3 - v11;
        let v13 = 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v13, v11));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v13, v12));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, v13);
        arg0.virtual_sui = arg0.virtual_sui + v5;
        arg0.virtual_tokens = arg0.virtual_tokens - v7;
        arg0.tokens_sold = arg0.tokens_sold + v7;
        emit_trade<T0>(arg0, true, v5, v7, v11, v12, arg5, arg6);
        if (arg0.tokens_sold == arg0.curve_supply) {
            arg0.complete = true;
            let v14 = CurveCompleted{
                curve_id     : 0x2::object::id<BondingCurve<T0>>(arg0),
                coin_type    : coin_type<T0>(),
                sui_reserve  : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
                timestamp_ms : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<CurveCompleted>(v14);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v7), arg7)
    }

    public fun claim_creator_fees<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 108);
        let v0 = CreatorFeesClaimed{
            curve_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            creator  : arg0.creator,
            amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees),
        };
        0x2::event::emit<CreatorFeesClaimed>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg1)
    }

    public fun claim_platform_fees<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::AdminCap, arg1: &mut BondingCurve<T0>, arg2: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PlatformFeesClaimed{
            curve_id : 0x2::object::id<BondingCurve<T0>>(arg1),
            amount   : 0x2::balance::value<0x2::sui::SUI>(&arg1.platform_fees),
        };
        0x2::event::emit<PlatformFeesClaimed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.platform_fees), arg3), 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::fee_recipient(arg2));
    }

    fun coin_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))
    }

    public fun create<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        create_for<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6, arg7)
    }

    public(friend) fun create_for<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_version(arg0);
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_not_paused(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::launch_fee(arg0), 102);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg4, arg5, &mut arg1, arg8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg4, arg5, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::tick_spacing(arg0), &v0, arg8);
        let v1 = new_curve<T0>(arg0, arg1, arg2, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v0), arg6, arg7, arg8);
        0x2::balance::join<0x2::sui::SUI>(&mut v1.platform_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        v1
    }

    public fun creator<T0>(arg0: &BondingCurve<T0>) : address {
        arg0.creator
    }

    public fun creator_fees<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    fun emit_trade<T0>(arg0: &BondingCurve<T0>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &0x2::clock::Clock) {
        let v0 = Trade{
            curve_id       : 0x2::object::id<BondingCurve<T0>>(arg0),
            coin_type      : coin_type<T0>(),
            trader         : arg6,
            is_buy         : arg1,
            sui_amount     : arg2,
            token_amount   : arg3,
            creator_fee    : arg4,
            platform_fee   : arg5,
            virtual_sui    : arg0.virtual_sui,
            virtual_tokens : arg0.virtual_tokens,
            tokens_sold    : arg0.tokens_sold,
            sui_reserve    : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve),
            timestamp_ms   : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<Trade>(v0);
    }

    public fun graduate<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_version(arg1);
        assert!(arg0.complete, 104);
        assert!(!arg0.graduated, 105);
        arg0.graduated = true;
        let v0 = mul_div(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg0.graduation_fee_bps, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v0));
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve);
        let v2 = mul_div(0x2::balance::value<T0>(&arg0.token_reserve), 9990, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps());
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg0.tick_spacing);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, 0x2::sui::SUI>(arg2, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.pool_creation_cap), arg0.tick_spacing, sqrt_price_x64(v1, v2), 0x1::string::utf8(b""), v3, v4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_reserve, v2), arg6), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_reserve), arg6), true, arg5, arg6);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v10);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::coin::into_balance<0x2::sui::SUI>(v8));
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(v9));
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury), 0x2::balance::withdraw_all<T0>(&mut arg0.token_reserve));
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v10, arg6), arg0.creator);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(v11);
        let v12 = Graduated{
            curve_id           : 0x2::object::id<BondingCurve<T0>>(arg0),
            coin_type          : coin_type<T0>(),
            pool_id            : v11,
            sui_liquidity      : v1 - 0x2::coin::value<0x2::sui::SUI>(&v8),
            token_liquidity    : v2 - 0x2::coin::value<T0>(&v9),
            tokens_burned      : 0x2::balance::value<T0>(&arg0.token_reserve),
            graduation_fee     : v0,
            lp_proof_recipient : arg0.creator,
            timestamp_ms       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<Graduated>(v12);
    }

    public fun is_complete<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.complete
    }

    public fun is_graduated<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.graduated
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128);
        ((((arg0 as u128) * (arg1 as u128) + v0 - 1) / v0) as u64)
    }

    fun new_curve<T0>(arg0: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 100);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::decimals(), 101);
        let v0 = BondingCurve<T0>{
            id                 : 0x2::object::new(arg6),
            creator            : arg4,
            treasury           : arg1,
            pool_creation_cap  : arg3,
            token_reserve      : 0x2::coin::mint_balance<T0>(&mut arg1, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::total_supply()),
            sui_reserve        : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fees       : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fees      : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui        : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::initial_virtual_sui(arg0),
            virtual_tokens     : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::initial_virtual_tokens(arg0),
            tokens_sold        : 0,
            curve_supply       : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::curve_supply(arg0),
            trade_fee_bps      : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::trade_fee_bps(arg0),
            creator_fee_bps    : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::creator_fee_bps(arg0),
            graduation_fee_bps : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::graduation_fee_bps(arg0),
            tick_spacing       : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::tick_spacing(arg0),
            complete           : false,
            graduated          : false,
            pool_id            : 0x1::option::none<0x2::object::ID>(),
        };
        let v1 = 0x2::coin::get_icon_url<T0>(arg2);
        let v2 = if (0x1::option::is_some<0x2::url::Url>(&v1)) {
            let v3 = 0x1::option::destroy_some<0x2::url::Url>(v1);
            0x1::string::from_ascii(0x2::url::inner_url(&v3))
        } else {
            0x1::string::utf8(b"")
        };
        let v4 = CurveCreated{
            curve_id        : 0x2::object::id<BondingCurve<T0>>(&v0),
            coin_type       : coin_type<T0>(),
            creator         : v0.creator,
            name            : 0x2::coin::get_name<T0>(arg2),
            symbol          : 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg2)),
            description     : 0x2::coin::get_description<T0>(arg2),
            icon_url        : v2,
            virtual_sui     : v0.virtual_sui,
            virtual_tokens  : v0.virtual_tokens,
            curve_supply    : v0.curve_supply,
            total_supply    : 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::total_supply(),
            trade_fee_bps   : v0.trade_fee_bps,
            creator_fee_bps : v0.creator_fee_bps,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CurveCreated>(v4);
        v0
    }

    public fun platform_fees<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees)
    }

    public fun quote_buy<T0>(arg0: &BondingCurve<T0>, arg1: u64) : u64 {
        let v0 = arg1 - mul_div_up(arg1, arg0.trade_fee_bps, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps());
        0x1::u64::min(mul_div(arg0.virtual_tokens, v0, arg0.virtual_sui + v0), arg0.curve_supply - arg0.tokens_sold)
    }

    public fun quote_sell<T0>(arg0: &BondingCurve<T0>, arg1: u64) : u64 {
        let v0 = mul_div(arg0.virtual_sui, arg1, arg0.virtual_tokens + arg1);
        v0 - mul_div_up(v0, arg0.trade_fee_bps, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps())
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg5);
        sell_as<T0>(arg0, arg1, arg2, arg3, v0, arg4, arg5)
    }

    public(friend) fun sell_as<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_version(arg1);
        0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::assert_not_paused(arg1);
        assert!(!arg0.complete, 103);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 106);
        let v1 = mul_div(arg0.virtual_sui, v0, arg0.virtual_tokens + v0);
        assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), 110);
        let v2 = mul_div_up(v1, arg0.trade_fee_bps, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps());
        let v3 = 0x1::u64::min(mul_div(v1, arg0.creator_fee_bps, 0x53e2c378a6e3619f8c2d601ac888e87526b44b1f6fc45762a68275200dc21203::config::bps()), v2);
        let v4 = v2 - v3;
        let v5 = v1 - v2;
        assert!(v5 > 0, 106);
        assert!(v5 >= arg3, 107);
        0x2::balance::join<T0>(&mut arg0.token_reserve, 0x2::coin::into_balance<T0>(arg2));
        arg0.virtual_sui = arg0.virtual_sui - v1;
        arg0.virtual_tokens = arg0.virtual_tokens + v0;
        arg0.tokens_sold = arg0.tokens_sold - v0;
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v3));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v4));
        emit_trade<T0>(arg0, false, v1, v0, v3, v4, arg4, arg5);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg6)
    }

    public fun share<T0>(arg0: BondingCurve<T0>) {
        0x2::transfer::share_object<BondingCurve<T0>>(arg0);
    }

    public(friend) fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        (sqrt_u256(((arg0 as u256) << 128) / (arg1 as u256)) as u128)
    }

    fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        let v1 = 1 << (((v0 + 1) / 2) as u8);
        loop {
            let v2 = v1 + arg0 / v1 >> 1;
            if (v2 >= v1) {
                break
            };
            v1 = v2;
        };
        v1
    }

    public fun sui_reserve<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public(friend) fun take_creator_fees<T0>(arg0: &mut BondingCurve<T0>, arg1: address) : 0x2::balance::Balance<0x2::sui::SUI> {
        assert!(arg1 == arg0.creator, 108);
        let v0 = CreatorFeesClaimed{
            curve_id : 0x2::object::id<BondingCurve<T0>>(arg0),
            creator  : arg0.creator,
            amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees),
        };
        0x2::event::emit<CreatorFeesClaimed>(v0);
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees)
    }

    public fun token_reserve<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.token_reserve)
    }

    public fun tokens_sold<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.tokens_sold
    }

    public fun virtual_reserves<T0>(arg0: &BondingCurve<T0>) : (u64, u64) {
        (arg0.virtual_sui, arg0.virtual_tokens)
    }

    // decompiled from Move bytecode v7
}

