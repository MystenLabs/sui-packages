module 0xa0ef234cf06843fa8e6f60cc679cefce527bb3579147fc6450985677c2e52743::consolidated {
    struct CONSOLIDATED has drop {
        dummy_field: bool,
    }

    struct TokenRegistry has key {
        id: 0x2::object::UID,
        tokens: 0x2::table::Table<address, TokenInfo>,
        admin: address,
        treasury: 0x2::coin::TreasuryCap<CONSOLIDATED>,
    }

    struct TokenInfo has copy, store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        decimals: u8,
        max_supply: u64,
        creator: address,
        created_at: u64,
        bonding_curve_id: address,
    }

    struct BondingCurve has store, key {
        id: 0x2::object::UID,
        token_id: address,
        total_minted: u256,
        sui_treasury: 0x2::coin::Coin<0x2::sui::SUI>,
        pool_created: bool,
        pool_id: 0x1::option::Option<address>,
        admin: address,
        fee_bps: u64,
        token_info: TokenInfo,
    }

    struct TokenCreatedEvent has copy, drop {
        token_id: address,
        bonding_curve_id: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        creator: address,
        decimals: u8,
        max_supply: u64,
    }

    struct BuyTokensEvent has copy, drop {
        token_id: address,
        amount: u64,
        required_payment: u64,
        total_minted: u64,
        sender: address,
    }

    struct SellTokensEvent has copy, drop {
        token_id: address,
        amount: u64,
        refund_amount: u64,
        total_minted: u64,
        sender: address,
    }

    struct PoolCreatedEvent has copy, drop {
        token_id: address,
        pool_id: address,
        base_token_amount: u64,
        quote_token_amount: u64,
        sender: address,
    }

    public entry fun buy_tokens(arg0: &mut TokenRegistry, arg1: &mut BondingCurve, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u256, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<CONSOLIDATED>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg3 as u64);
        assert!(arg3 <= (18446744073709551615 as u256), 4);
        let v1 = calculate_buy_price(arg1.total_minted, arg3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v3 = checked_mul_u64(v1, arg1.fee_bps);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u64>(&mut v3) / 10000;
        let v5 = v1 + v4;
        assert!(v2 >= v5, 3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg9), arg1.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<CONSOLIDATED>>(0x2::coin::mint<CONSOLIDATED>(&mut arg0.treasury, v0, arg9), 0x2::tx_context::sender(arg9));
        arg1.total_minted = arg1.total_minted + arg3;
        if (v2 > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v2 - v5, arg9), 0x2::tx_context::sender(arg9));
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.sui_treasury, arg2);
        let v6 = BuyTokensEvent{
            token_id         : arg1.token_id,
            amount           : v0,
            required_payment : v1,
            total_minted     : (arg1.total_minted as u64),
            sender           : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<BuyTokensEvent>(v6);
        try_create_pool(arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun calculate_buy_price(arg0: u256, arg1: u256) : u64 {
        if (arg1 == 0) {
            return 0
        };
        assert!(arg1 <= (18446744073709551615 as u256), 4);
        assert!(arg0 <= (18446744073709551615 as u256), 4);
        let v0 = arg0 / 1000000000;
        assert!(v0 <= 100000000, 4);
        let v1 = checked_mul_u256(v0, (100 as u256));
        if (!0x1::option::is_some<u256>(&v1)) {
            abort 1
        };
        let v2 = checked_add_u256(0x1::option::extract<u256>(&mut v1), (10000 as u256));
        if (!0x1::option::is_some<u256>(&v2)) {
            abort 1
        };
        let v3 = checked_mul_u256(arg1, 0x1::option::extract<u256>(&mut v2));
        if (!0x1::option::is_some<u256>(&v3)) {
            abort 1
        };
        let v4 = checked_div_u256(0x1::option::extract<u256>(&mut v3), 1000000000);
        if (!0x1::option::is_some<u256>(&v4)) {
            abort 1
        };
        let v5 = 0x1::option::extract<u256>(&mut v4);
        if (v5 > (18446744073709551615 as u256)) {
            abort 5
        };
        (v5 as u64)
    }

    public fun calculate_sell_price(arg0: u256, arg1: u256) : u64 {
        assert!(arg1 <= (18446744073709551615 as u256), 4);
        assert!(arg0 <= (18446744073709551615 as u256), 4);
        let v0 = checked_mul_u256((arg0 - arg1) / 1000000000, (100 as u256));
        if (!0x1::option::is_some<u256>(&v0)) {
            abort 1
        };
        let v1 = checked_add_u256(0x1::option::extract<u256>(&mut v0), (10000 as u256));
        if (!0x1::option::is_some<u256>(&v1)) {
            abort 1
        };
        let v2 = checked_mul_u256(arg1, 0x1::option::extract<u256>(&mut v1));
        if (!0x1::option::is_some<u256>(&v2)) {
            abort 1
        };
        let v3 = checked_div_u256(0x1::option::extract<u256>(&mut v2), 1000000000);
        if (!0x1::option::is_some<u256>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u256>(&mut v3);
        if (v4 > (18446744073709551615 as u256)) {
            abort 5
        };
        (v4 as u64)
    }

    public entry fun change_admin(arg0: &mut BondingCurve, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 10);
        assert!(arg1 != @0x0, 6);
        arg0.admin = arg1;
    }

    public fun checked_add_u256(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        let v0 = arg0 + arg1;
        if (v0 < arg0 || v0 < arg1) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(v0)
        }
    }

    public fun checked_add_u64(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = arg0 + arg1;
        if (v0 < arg0 || v0 < arg1) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v0)
        }
    }

    public fun checked_div_u256(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        if (arg1 == 0) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(arg0 / arg1)
        }
    }

    public fun checked_div_u64(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg1 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0 / arg1)
        }
    }

    public fun checked_mul_u256(arg0: u256, arg1: u256) : 0x1::option::Option<u256> {
        if (arg0 == 0 || arg1 == 0) {
            return 0x1::option::some<u256>(0)
        };
        let v0 = arg0 * arg1;
        if (arg1 != 0 && v0 / arg1 != arg0) {
            0x1::option::none<u256>()
        } else {
            0x1::option::some<u256>(v0)
        }
    }

    public fun checked_mul_u64(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 == 0 || arg1 == 0) {
            return 0x1::option::some<u64>(0)
        };
        let v0 = arg0 * arg1;
        if (v0 / arg0 != arg1) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(v0)
        }
    }

    public fun checked_sub_u64(arg0: u64, arg1: u64) : 0x1::option::Option<u64> {
        if (arg0 < arg1) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(arg0 - arg1)
        }
    }

    public entry fun create_token_and_bonding_curve(arg0: &mut TokenRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg8);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = 0x2::object::uid_to_address(&v0);
        let v3 = TokenInfo{
            name             : 0x1::string::utf8(arg1),
            symbol           : 0x1::string::utf8(arg2),
            description      : 0x1::string::utf8(arg3),
            icon_url         : 0x1::string::utf8(arg4),
            decimals         : arg5,
            max_supply       : arg6,
            creator          : 0x2::tx_context::sender(arg8),
            created_at       : 0x2::tx_context::epoch(arg8),
            bonding_curve_id : v2,
        };
        0x2::table::add<address, TokenInfo>(&mut arg0.tokens, v1, v3);
        let v4 = BondingCurve{
            id           : v0,
            token_id     : v1,
            total_minted : 0,
            sui_treasury : 0x2::coin::zero<0x2::sui::SUI>(arg8),
            pool_created : false,
            pool_id      : 0x1::option::none<address>(),
            admin        : 0x2::tx_context::sender(arg8),
            fee_bps      : arg7,
            token_info   : v3,
        };
        let v5 = TokenCreatedEvent{
            token_id         : v1,
            bonding_curve_id : v2,
            name             : 0x1::string::utf8(arg1),
            symbol           : 0x1::string::utf8(arg2),
            creator          : 0x2::tx_context::sender(arg8),
            decimals         : arg5,
            max_supply       : arg6,
        };
        0x2::event::emit<TokenCreatedEvent>(v5);
        0x2::transfer::share_object<BondingCurve>(v4);
    }

    public fun get_bonding_curve_token_info(arg0: &BondingCurve) : &TokenInfo {
        &arg0.token_info
    }

    public fun get_curve_info(arg0: &BondingCurve) : (address, u256, bool, u64) {
        (arg0.token_id, arg0.total_minted, arg0.pool_created, arg0.fee_bps)
    }

    public fun get_token_info(arg0: &TokenRegistry, arg1: address) : &TokenInfo {
        0x2::table::borrow<address, TokenInfo>(&arg0.tokens, arg1)
    }

    fun init(arg0: CONSOLIDATED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONSOLIDATED>(arg0, 9, b"LAUNCH", b"Launchpad Token", b"Universal token for all meme launches", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONSOLIDATED>>(v1);
        let v2 = TokenRegistry{
            id       : 0x2::object::new(arg1),
            tokens   : 0x2::table::new<address, TokenInfo>(arg1),
            admin    : 0x2::tx_context::sender(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<TokenRegistry>(v2);
    }

    public fun init_cetus_pool(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<CONSOLIDATED>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<CONSOLIDATED>, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : bool {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 11);
        assert!(0x2::coin::value<CONSOLIDATED>(&arg2) >= 40000000000000, 11);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<CONSOLIDATED, 0x2::sui::SUI>(arg4, arg3, 200, 92233720368547760, 0x1::string::utf8(b""), 4294523696, 443600, 0x2::coin::split<CONSOLIDATED>(&mut arg2, 40000000000000, arg9), 0x2::coin::split<0x2::sui::SUI>(&mut arg1, 1000000000, arg9), arg6, arg5, true, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, arg0);
        if (0x2::coin::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
        };
        if (0x2::coin::value<CONSOLIDATED>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CONSOLIDATED>>(v4, arg0);
        } else {
            0x2::coin::destroy_zero<CONSOLIDATED>(v4);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (0x2::coin::value<CONSOLIDATED>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CONSOLIDATED>>(arg2, arg0);
        } else {
            0x2::coin::destroy_zero<CONSOLIDATED>(arg2);
        };
        let v5 = PoolCreatedEvent{
            token_id           : arg7,
            pool_id            : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools>(arg3),
            base_token_amount  : 1000000000,
            quote_token_amount : 40000000000000,
            sender             : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<PoolCreatedEvent>(v5);
        true
    }

    public entry fun sell_tokens(arg0: &mut TokenRegistry, arg1: &mut BondingCurve, arg2: &mut 0x2::coin::Coin<CONSOLIDATED>, arg3: u256, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x2::clock::Clock, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<CONSOLIDATED>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg3 as u64);
        assert!(0x2::coin::value<CONSOLIDATED>(arg2) >= v0, 7);
        let v1 = calculate_sell_price(arg1.total_minted, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury) >= v1, 3);
        0x2::coin::burn<CONSOLIDATED>(&mut arg0.treasury, 0x2::coin::split<CONSOLIDATED>(arg2, v0, arg9));
        arg1.total_minted = arg1.total_minted - arg3;
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, v1, arg9);
        let v3 = checked_mul_u64(v1, arg1.fee_bps);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u64>(&mut v3) / 10000;
        if (v4 > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= v4, 3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg9), arg1.admin);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg9));
        let v5 = SellTokensEvent{
            token_id      : arg1.token_id,
            amount        : v0,
            refund_amount : v1,
            total_minted  : (arg1.total_minted as u64),
            sender        : 0x2::tx_context::sender(arg9),
        };
        0x2::event::emit<SellTokensEvent>(v5);
    }

    public entry fun set_fee_bps(arg0: &mut BondingCurve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 10);
        assert!(arg1 <= 10000, 6);
        arg0.fee_bps = arg1;
    }

    fun try_create_pool(arg0: &mut TokenRegistry, arg1: &mut BondingCurve, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x2::clock::Clock, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<CONSOLIDATED>, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg1.pool_created) {
            return
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1.sui_treasury) < 1200000000) {
            return
        };
        let v0 = 0x2::coin::mint<CONSOLIDATED>(&mut arg0.treasury, 40000000000000, arg7);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg1.sui_treasury, 1000000000, arg7);
        if (init_cetus_pool(arg1.admin, v1, v0, arg3, arg2, arg5, arg6, arg1.token_id, arg4, arg7)) {
            arg1.pool_created = true;
        };
    }

    // decompiled from Move bytecode v6
}

