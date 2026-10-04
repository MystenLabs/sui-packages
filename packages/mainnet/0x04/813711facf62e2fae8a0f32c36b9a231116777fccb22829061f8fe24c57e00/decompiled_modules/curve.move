module 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve {
    struct Curve<phantom T0> has key {
        id: 0x2::object::UID,
        pad: 0x2::object::ID,
        index: u64,
        creator: address,
        status: u8,
        created_at_ms: u64,
        graduated_at_ms: u64,
        supply: u64,
        virtual_reserve0: u64,
        virtual_tokens0: u64,
        target_reserve: u64,
        graduation_fee: u64,
        fee_bps: u16,
        creator_share_bps: u16,
        platform_bps: u16,
        graduation_bounty: u64,
        tick_spacing: u32,
        tokens_sold: u64,
        tokens: 0x2::balance::Balance<T0>,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        owner_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        pool_cap: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>,
        pool: 0x1::option::Option<0x2::object::ID>,
        lp_proof: 0x1::option::Option<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>,
    }

    struct CurveCreated has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
        index: u64,
    }

    struct Launched has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        coin_type: 0x1::string::String,
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        icon_url: 0x1::string::String,
        supply: u64,
        virtual_reserve: u64,
        virtual_tokens: u64,
        target_reserve: u64,
    }

    struct Trade has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        trader: address,
        is_buy: bool,
        reserve_amount: u64,
        token_amount: u64,
        fee: u64,
        virtual_reserve: u64,
        virtual_tokens: u64,
        reserve_raised: u64,
    }

    struct CurveCompleted has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        reserve_raised: u64,
    }

    struct Graduated has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        pool: 0x2::object::ID,
        reserve_liquidity: u64,
        token_liquidity: u64,
        tokens_burned: u64,
        liquidity: u128,
        lp_proof: 0x2::object::ID,
    }

    struct GraduationBountyPaid has copy, drop {
        curve: 0x2::object::ID,
        caller: address,
        amount: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        curve: 0x2::object::ID,
        creator: address,
        amount: u64,
    }

    struct CreatorUpdated has copy, drop {
        curve: 0x2::object::ID,
        new_creator: address,
    }

    public fun decimals() : u8 {
        6
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: u16, arg10: u16, arg11: u64, arg12: u32, arg13: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Curve<T0>{
            id                : 0x2::object::new(arg15),
            pad               : arg0,
            index             : arg1,
            creator           : arg2,
            status            : 0,
            created_at_ms     : 0x2::clock::timestamp_ms(arg14),
            graduated_at_ms   : 0,
            supply            : 0x2::balance::value<T0>(&arg3),
            virtual_reserve0  : arg4,
            virtual_tokens0   : arg5,
            target_reserve    : arg6,
            graduation_fee    : arg7,
            fee_bps           : arg8,
            creator_share_bps : arg9,
            platform_bps      : arg10,
            graduation_bounty : arg11,
            tick_spacing      : arg12,
            tokens_sold       : 0,
            tokens            : arg3,
            reserve           : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_fees      : 0x2::balance::zero<0x2::sui::SUI>(),
            owner_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fees     : 0x2::balance::zero<0x2::sui::SUI>(),
            pool_cap          : arg13,
            pool              : 0x1::option::none<0x2::object::ID>(),
            lp_proof          : 0x1::option::none<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(),
        };
        let v1 = 0x2::object::id<Curve<T0>>(&v0);
        let v2 = CurveCreated{
            pad       : arg0,
            curve     : v1,
            coin_type : coin_type<T0>(),
            creator   : arg2,
            index     : arg1,
        };
        0x2::event::emit<CurveCreated>(v2);
        0x2::transfer::share_object<Curve<T0>>(v0);
        v1
    }

    public fun activate<T0>(arg0: &mut Curve<T0>, arg1: &0x2::coin_registry::Currency<T0>) {
        assert!(arg0.status == 0, 13906835260971024399);
        assert!(0x2::coin_registry::is_supply_burn_only<T0>(arg1), 13906835269561221139);
        assert!(0x2::coin_registry::total_supply<T0>(arg1) == 0x1::option::some<u64>(arg0.supply), 13906835273856188435);
        assert!(!0x2::coin_registry::is_regulated<T0>(arg1), 13906835282446123027);
        assert!(0x2::coin_registry::is_metadata_cap_deleted<T0>(arg1), 13906835291036057619);
        assert!(0x2::coin_registry::decimals<T0>(arg1) == 6, 13906835295331024915);
        let v0 = 0x2::coin_registry::name<T0>(arg1);
        let v1 = 0x2::coin_registry::symbol<T0>(arg1);
        assert!(0x1::string::length(&v0) > 0 && 0x1::string::length(&v1) > 0, 13906835308215926803);
        arg0.status = 1;
        let v2 = Launched{
            pad             : arg0.pad,
            curve           : 0x2::object::id<Curve<T0>>(arg0),
            coin_type       : coin_type<T0>(),
            creator         : arg0.creator,
            name            : v0,
            symbol          : v1,
            icon_url        : 0x2::coin_registry::icon_url<T0>(arg1),
            supply          : arg0.supply,
            virtual_reserve : arg0.virtual_reserve0,
            virtual_tokens  : arg0.virtual_tokens0,
            target_reserve  : arg0.target_reserve,
        };
        0x2::event::emit<Launched>(v2);
    }

    public fun buy<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 1, 13906835432769585165);
        assert!(arg2 > 0, 13906835437064290313);
        let (v0, v1) = split_in<T0>(arg0, arg2);
        let (v2, v3) = reserves<T0>(arg0);
        let v4 = mul_div(v0, v3, (v2 as u128) + (v0 as u128));
        assert!(v4 >= arg3, 13906835458539257867);
        assert!(v4 > 0, 13906835462834094089);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 + v1, arg4));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve, v5);
        arg0.tokens_sold = arg0.tokens_sold + v4;
        split_trade_fee<T0>(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v1));
        emit_trade<T0>(arg0, 0x2::tx_context::sender(arg4), true, v0, v4, v1);
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.reserve) >= arg0.target_reserve) {
            arg0.status = 2;
            let v6 = CurveCompleted{
                pad            : arg0.pad,
                curve          : 0x2::object::id<Curve<T0>>(arg0),
                reserve_raised : 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve),
            };
            0x2::event::emit<CurveCompleted>(v6);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.tokens, v4), arg4)
    }

    public fun claim_creator_fees<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees);
        if (v0 == 0) {
            return 0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees), arg1), arg0.creator);
        let v1 = CreatorFeesClaimed{
            curve   : 0x2::object::id<Curve<T0>>(arg0),
            creator : arg0.creator,
            amount  : v0,
        };
        0x2::event::emit<CreatorFeesClaimed>(v1);
        v0
    }

    public fun coin_type<T0>() : 0x1::string::String {
        0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()))
    }

    public fun created_at_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun creator<T0>(arg0: &Curve<T0>) : address {
        arg0.creator
    }

    public fun creator_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun creator_share_bps<T0>(arg0: &Curve<T0>) : u16 {
        arg0.creator_share_bps
    }

    fun emit_trade<T0>(arg0: &Curve<T0>, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        let (v0, v1) = reserves<T0>(arg0);
        let v2 = Trade{
            pad             : arg0.pad,
            curve           : 0x2::object::id<Curve<T0>>(arg0),
            trader          : arg1,
            is_buy          : arg2,
            reserve_amount  : arg3,
            token_amount    : arg4,
            fee             : arg5,
            virtual_reserve : v0,
            virtual_tokens  : v1,
            reserve_raised  : 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve),
        };
        0x2::event::emit<Trade>(v2);
    }

    public fun fee_bps<T0>(arg0: &Curve<T0>) : u16 {
        arg0.fee_bps
    }

    public fun graduate<T0>(arg0: &mut Curve<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.status == 2, 13906835742007492625);
        let v0 = 0x2::object::id<Curve<T0>>(arg0);
        let (v1, v2) = reserves<T0>(arg0);
        let v3 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, arg0.graduation_fee);
        let v4 = if (arg0.graduation_bounty < arg0.graduation_fee) {
            arg0.graduation_bounty
        } else {
            arg0.graduation_fee
        };
        if (v4 > 0) {
            let v5 = GraduationBountyPaid{
                curve  : v0,
                caller : 0x2::tx_context::sender(arg6),
                amount : v4,
            };
            0x2::event::emit<GraduationBountyPaid>(v5);
        };
        split_pad_fee<T0>(arg0, v3);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve);
        let v7 = 0x2::balance::value<T0>(&arg0.tokens);
        let v8 = mul_div(v6, v2, (v1 as u128));
        let v9 = (v7 as u128) >= (v8 as u128) + (v8 as u128) / 10000 + 10;
        let v10 = 0x2::balance::withdraw_all<T0>(&mut arg0.tokens);
        let v11 = if (v9) {
            v7
        } else {
            v7 - v7 / 10000
        };
        let (v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(arg0.tick_spacing);
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v3_with_creation_cap<T0, 0x2::sui::SUI>(arg2, arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(&arg0.pool_cap), arg0.tick_spacing, sqrt_price_x64(v1, v2), 0x1::string::utf8(b""), v12, v13, 0x2::coin::from_balance<T0>(v10, arg6), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.reserve), arg6), !v9, arg5, arg6);
        let v17 = v16;
        let v18 = v15;
        let v19 = v14;
        let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v19);
        split_pad_fee<T0>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v17));
        let v21 = 0x2::coin::into_balance<T0>(v18);
        0x2::balance::join<T0>(&mut v21, 0x2::balance::split<T0>(&mut v10, v7 - v11));
        let v22 = 0x2::balance::value<T0>(&v21);
        if (v22 > 0) {
            0x2::coin_registry::burn_balance<T0>(arg1, v21);
        } else {
            0x2::balance::destroy_zero<T0>(v21);
        };
        let v23 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v19, arg6);
        0x1::option::fill<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg0.lp_proof, v23);
        0x1::option::fill<0x2::object::ID>(&mut arg0.pool, v20);
        arg0.status = 3;
        arg0.graduated_at_ms = 0x2::clock::timestamp_ms(arg5);
        let v24 = Graduated{
            pad               : arg0.pad,
            curve             : v0,
            pool              : v20,
            reserve_liquidity : v6 - 0x2::coin::value<0x2::sui::SUI>(&v17),
            token_liquidity   : v11 - 0x2::coin::value<T0>(&v18),
            tokens_burned     : v22,
            liquidity         : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&v19),
            lp_proof          : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v23),
        };
        0x2::event::emit<Graduated>(v24);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v4), arg6)
    }

    public fun graduated_at_ms<T0>(arg0: &Curve<T0>) : u64 {
        arg0.graduated_at_ms
    }

    public fun graduation_bounty<T0>(arg0: &Curve<T0>) : u64 {
        arg0.graduation_bounty
    }

    public fun graduation_fee<T0>(arg0: &Curve<T0>) : u64 {
        arg0.graduation_fee
    }

    public fun index<T0>(arg0: &Curve<T0>) : u64 {
        arg0.index
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u128) : u64 {
        (((arg0 as u128) * (arg1 as u128) / arg2) as u64)
    }

    public fun owner_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.owner_fees)
    }

    public fun pad<T0>(arg0: &Curve<T0>) : 0x2::object::ID {
        arg0.pad
    }

    public fun platform_bps<T0>(arg0: &Curve<T0>) : u16 {
        arg0.platform_bps
    }

    public fun platform_fees<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees)
    }

    public fun pool<T0>(arg0: &Curve<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool
    }

    public fun progress<T0>(arg0: &Curve<T0>) : u64 {
        if (arg0.status >= 2) {
            return 10000
        };
        (((0x2::balance::value<0x2::sui::SUI>(&arg0.reserve) as u128) * 10000 / (arg0.target_reserve as u128)) as u64)
    }

    public fun quote_buy<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64, u64) {
        if (arg0.status != 1 || arg1 == 0) {
            return (0, 0, 0)
        };
        let (v0, v1) = split_in<T0>(arg0, arg1);
        let (v2, v3) = reserves<T0>(arg0);
        (mul_div(v0, v3, (v2 as u128) + (v0 as u128)), v0 + v1, v1)
    }

    public fun quote_sell<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64) {
        if (arg0.status != 1 || arg1 == 0) {
            return (0, 0)
        };
        let (v0, v1) = reserves<T0>(arg0);
        let v2 = mul_div(arg1, v0, (v1 as u128) + (arg1 as u128));
        let v3 = v2;
        if (v2 > 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve)) {
            v3 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve);
        };
        let v4 = (((v3 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        (v3 - v4, v4)
    }

    public fun reserve_raised<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve)
    }

    public fun reserves<T0>(arg0: &Curve<T0>) : (u64, u64) {
        (arg0.virtual_reserve0 + 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve), arg0.virtual_tokens0 - arg0.tokens_sold)
    }

    public fun sell<T0>(arg0: &mut Curve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.status == 1, 13906835587388407821);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13906835595978080265);
        let (v1, v2) = reserves<T0>(arg0);
        let v3 = mul_div(v0, v1, (v2 as u128) + (v0 as u128));
        let v4 = v3;
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve);
        if (v3 > v5) {
            v4 = v5;
        };
        let v6 = (((v4 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        let v7 = v4 - v6;
        assert!(v7 >= arg2, 13906835630337949707);
        arg0.tokens_sold = arg0.tokens_sold - v0;
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg1));
        let v8 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.reserve, v4);
        split_trade_fee<T0>(arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v8, v6));
        emit_trade<T0>(arg0, 0x2::tx_context::sender(arg3), false, v7, v0, v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v8, arg3)
    }

    public fun set_creator<T0>(arg0: &mut Curve<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 13906836248812978183);
        assert!(arg1 != @0x0, 13906836253108076553);
        arg0.creator = arg1;
        let v0 = CreatorUpdated{
            curve       : 0x2::object::id<Curve<T0>>(arg0),
            new_creator : arg1,
        };
        0x2::event::emit<CreatorUpdated>(v0);
    }

    fun split_in<T0>(arg0: &Curve<T0>, arg1: u64) : (u64, u64) {
        let v0 = (((arg1 as u128) * 10000 / (10000 + (arg0.fee_bps as u128))) as u64);
        let v1 = arg0.target_reserve - 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve);
        if (v0 > v1) {
            (v1, (((v1 as u128) * (arg0.fee_bps as u128) / 10000) as u64))
        } else {
            (v0, arg1 - v0)
        }
    }

    fun split_pad_fee<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, (((0x2::balance::value<0x2::sui::SUI>(&arg1) as u128) * (arg0.platform_bps as u128) / 10000) as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, arg1);
    }

    fun split_trade_fee<T0>(arg0: &mut Curve<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            return
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, (((v0 as u128) * (arg0.creator_share_bps as u128) / 10000) as u64)));
        split_pad_fee<T0>(arg0, arg1);
    }

    public fun sqrt_price_x64(arg0: u64, arg1: u64) : u128 {
        (sqrt_u256(((arg0 as u256) << 128) / (arg1 as u256)) as u128)
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = (arg0 >> 1) + 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 >> 1;
        };
        arg0
    }

    public fun status<T0>(arg0: &Curve<T0>) : u8 {
        arg0.status
    }

    public fun supply<T0>(arg0: &Curve<T0>) : u64 {
        arg0.supply
    }

    public(friend) fun take_pad_fees<T0>(arg0: &mut Curve<T0>) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>) {
        (0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.owner_fees), 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.platform_fees))
    }

    public fun target_reserve<T0>(arg0: &Curve<T0>) : u64 {
        arg0.target_reserve
    }

    public fun tick_spacing<T0>(arg0: &Curve<T0>) : u32 {
        arg0.tick_spacing
    }

    public fun tokens_left<T0>(arg0: &Curve<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun tokens_sold<T0>(arg0: &Curve<T0>) : u64 {
        arg0.tokens_sold
    }

    // decompiled from Move bytecode v7
}

