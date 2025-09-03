module 0x3d0202c2b4bb41c8c5099864ae9d8b4dbf55b52cacf925b47cdba54cda37e072::consolidated {
    struct MEME_TOKEN has drop {
        dummy_field: bool,
    }

    struct TokenCreationParams has copy, drop, store {
        name: vector<u8>,
        symbol: vector<u8>,
        description: vector<u8>,
        icon_url: vector<u8>,
        decimals: u8,
        max_supply: u64,
    }

    struct BuyTokensEvent has copy, drop {
        amount: u64,
        required_payment: u64,
        total_minted: u64,
        sender: address,
    }

    struct SellTokensEvent has copy, drop {
        amount: u64,
        refund_amount: u64,
        total_minted: u64,
        sender: address,
        treasury_balance: u64,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: address,
        base_token_amount: u64,
        quote_token_amount: u64,
        sender: address,
    }

    struct TokenCreatedEvent has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        max_supply: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TransferCoinEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
    }

    struct TreasuryCapTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    struct BondingCurve<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_minted: u256,
        treasury: 0x2::coin::TreasuryCap<T0>,
        sui_treasury: 0x2::coin::Coin<0x2::sui::SUI>,
        pool_created: bool,
        pool_id: 0x1::option::Option<address>,
        admin: address,
        fee_bps: u64,
        token_params: TokenCreationParams,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MEME_TOKEN>, arg1: 0x2::coin::Coin<MEME_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MEME_TOKEN>(arg0, arg1);
        let v0 = BurnEvent{
            amount : 0x2::coin::value<MEME_TOKEN>(&arg1),
            burner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEME_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::total_supply<MEME_TOKEN>(arg0) + arg1 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(0x2::coin::mint<MEME_TOKEN>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<MEME_TOKEN>) : u64 {
        0x2::coin::total_supply<MEME_TOKEN>(arg0)
    }

    public entry fun buy_tokens(arg0: &mut BondingCurve<MEME_TOKEN>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u256, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<MEME_TOKEN>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 as u64);
        assert!(arg2 <= (18446744073709551615 as u256), 4);
        let v1 = calculate_buy_price(arg0.total_minted, arg2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = checked_mul_u64(v1, arg0.fee_bps);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u64>(&mut v3) / 10000;
        let v5 = v1 + v4;
        assert!(v2 >= v5, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v4, arg8), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(0x2::coin::mint<MEME_TOKEN>(&mut arg0.treasury, v0, arg8), 0x2::tx_context::sender(arg8));
        arg0.total_minted = arg0.total_minted + arg2;
        let v6 = BuyTokensEvent{
            amount           : v0,
            required_payment : v1,
            total_minted     : (arg0.total_minted as u64),
            sender           : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<BuyTokensEvent>(v6);
        if (v2 > v1) {
            let v7 = checked_sub_u64(v2, v5);
            if (!0x1::option::is_some<u64>(&v7)) {
                abort 1
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x1::option::extract<u64>(&mut v7), arg8), 0x2::tx_context::sender(arg8));
        };
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui_treasury, arg1);
        try_create_pool(arg0, arg3, arg4, arg5, arg6, arg7, arg8);
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

    public entry fun change_admin(arg0: &mut BondingCurve<MEME_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
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

    public entry fun create_bonding_curve(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_meme_token(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME_TOKEN>>(v1, @0x0);
        let v2 = TokenCreationParams{
            name        : arg0,
            symbol      : arg1,
            description : arg2,
            icon_url    : arg3,
            decimals    : arg4,
            max_supply  : arg5,
        };
        let v3 = BondingCurve<MEME_TOKEN>{
            id           : 0x2::object::new(arg7),
            total_minted : 0,
            treasury     : v0,
            sui_treasury : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7),
            pool_created : false,
            pool_id      : 0x1::option::none<address>(),
            admin        : 0x2::tx_context::sender(arg7),
            fee_bps      : arg6,
            token_params : v2,
        };
        0x2::transfer::public_share_object<BondingCurve<MEME_TOKEN>>(v3);
    }

    public fun create_default_meme_token(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<MEME_TOKEN>, 0x2::coin::CoinMetadata<MEME_TOKEN>) {
        create_meme_token(arg0, arg1, arg2, arg3, 9, 1000000000000000000, arg4)
    }

    public fun create_meme_token(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<MEME_TOKEN>, 0x2::coin::CoinMetadata<MEME_TOKEN>) {
        let v0 = MEME_TOKEN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<MEME_TOKEN>(v0, arg4, arg1, arg0, arg2, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg3)), arg6);
        let v3 = TokenCreatedEvent{
            name       : 0x1::string::utf8(arg0),
            symbol     : 0x1::string::utf8(arg1),
            decimals   : arg4,
            max_supply : arg5,
        };
        0x2::event::emit<TokenCreatedEvent>(v3);
        (v1, v2)
    }

    public entry fun create_simple_bonding_curve(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        create_bonding_curve(arg0, arg1, arg2, arg3, 9, 1000000000000000000, arg4, arg5);
    }

    public fun get_curve_info<T0>(arg0: &BondingCurve<T0>) : (u256, bool, u64) {
        (arg0.total_minted, arg0.pool_created, arg0.fee_bps)
    }

    public fun get_token_params<T0>(arg0: &BondingCurve<T0>) : &TokenCreationParams {
        &arg0.token_params
    }

    public fun init_cetus_pool(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<MEME_TOKEN>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<MEME_TOKEN>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 200;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000000, 2);
        assert!(0x2::coin::value<MEME_TOKEN>(&arg2) >= 40000000000000, 2);
        let v1 = if (v0 == 100) {
            true
        } else if (v0 == 200) {
            true
        } else if (v0 == 500) {
            true
        } else {
            v0 == 3000
        };
        assert!(v1, 5);
        let (v2, v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<MEME_TOKEN, 0x2::sui::SUI>(arg4, arg3, v0, 92233720368547760, 0x1::string::utf8(b""), 4294523696, 443600, 0x2::coin::split<MEME_TOKEN>(&mut arg2, 40000000000000, arg8), 0x2::coin::split<0x2::sui::SUI>(&mut arg1, 1000000000, arg8), arg6, arg5, true, arg7, arg8);
        let v5 = v4;
        let v6 = v3;
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v2, arg0);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(&v5);
        let v8 = 0x2::coin::value<MEME_TOKEN>(&v6);
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, arg0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(v6, arg0);
        } else {
            0x2::coin::destroy_zero<MEME_TOKEN>(v6);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        if (0x2::coin::value<MEME_TOKEN>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(arg2, arg0);
        } else {
            0x2::coin::destroy_zero<MEME_TOKEN>(arg2);
        };
        let v9 = PoolCreatedEvent{
            pool_id            : 0x2::object::id_address<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools>(arg3),
            base_token_amount  : 1000000000 - v7,
            quote_token_amount : 40000000000000 - v8,
            sender             : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<PoolCreatedEvent>(v9);
        true
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    public entry fun sell_tokens(arg0: &mut BondingCurve<MEME_TOKEN>, arg1: &mut 0x2::coin::Coin<MEME_TOKEN>, arg2: u256, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg5: &0x2::clock::Clock, arg6: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg7: &0x2::coin::CoinMetadata<MEME_TOKEN>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 as u64);
        assert!(0x2::coin::value<MEME_TOKEN>(arg1) >= v0, 7);
        assert!(arg2 % 1000000000 == 0, 6);
        let v1 = calculate_sell_price(arg0.total_minted, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) >= v1, 3);
        0x2::coin::burn<MEME_TOKEN>(&mut arg0.treasury, 0x2::coin::split<MEME_TOKEN>(arg1, v0, arg8));
        arg0.total_minted = arg0.total_minted - arg2;
        let v2 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, v1, arg8);
        let v3 = checked_mul_u64(v1, arg0.fee_bps);
        if (!0x1::option::is_some<u64>(&v3)) {
            abort 1
        };
        let v4 = 0x1::option::extract<u64>(&mut v3) / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) >= v4, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg8), arg0.admin);
        let v5 = SellTokensEvent{
            amount           : v0,
            refund_amount    : v1,
            total_minted     : (arg0.total_minted as u64),
            sender           : 0x2::tx_context::sender(arg8),
            treasury_balance : 0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury),
        };
        0x2::event::emit<SellTokensEvent>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg8));
    }

    public entry fun set_fee_bps(arg0: &mut BondingCurve<MEME_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 6);
        assert!(arg1 <= 10000, 6);
        arg0.fee_bps = arg1;
    }

    public entry fun transfer_token(arg0: 0x2::coin::Coin<MEME_TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg2 == 0x2::coin::value<MEME_TOKEN>(&arg0)) {
            let v1 = TransferCoinEvent{
                from   : v0,
                to     : arg1,
                amount : arg2,
            };
            0x2::event::emit<TransferCoinEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(arg0, arg1);
        } else {
            let v2 = 0x2::coin::split<MEME_TOKEN>(&mut arg0, arg2, arg3);
            let v3 = TransferCoinEvent{
                from   : v0,
                to     : arg1,
                amount : 0x2::coin::value<MEME_TOKEN>(&v2),
            };
            0x2::event::emit<TransferCoinEvent>(v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(v2, arg1);
            let v4 = TransferCoinEvent{
                from   : v0,
                to     : v0,
                amount : 0x2::coin::value<MEME_TOKEN>(&arg0),
            };
            0x2::event::emit<TransferCoinEvent>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<MEME_TOKEN>>(arg0, v0);
        };
    }

    public entry fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<MEME_TOKEN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCapTransferred{
            previous_owner : 0x2::tx_context::sender(arg2),
            new_owner      : arg1,
            timestamp      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TreasuryCapTransferred>(v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_TOKEN>>(arg0, arg1);
    }

    fun try_create_pool(arg0: &mut BondingCurve<MEME_TOKEN>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::clock::Clock, arg4: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg5: &0x2::coin::CoinMetadata<MEME_TOKEN>, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg0.pool_created) {
            return
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg0.sui_treasury) < 1200000000) {
            return
        };
        let v0 = 0x2::coin::mint<MEME_TOKEN>(&mut arg0.treasury, 40000000000000, arg6);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg0.sui_treasury, 1000000000, arg6);
        if (init_cetus_pool(arg0.admin, v1, v0, arg2, arg1, arg4, arg5, arg3, arg6) == true) {
            arg0.pool_created = true;
        };
    }

    // decompiled from Move bytecode v6
}

