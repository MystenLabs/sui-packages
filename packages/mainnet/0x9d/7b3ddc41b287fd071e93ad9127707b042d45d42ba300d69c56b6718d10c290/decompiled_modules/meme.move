module 0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::meme {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        meme_balance: 0x2::balance::Balance<T0>,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_amt: u64,
        virtual_token_amt: u64,
        is_active: bool,
        swap_fee: u64,
        creator: address,
        migratedToDex: bool,
    }

    struct Configurator has key {
        id: 0x2::object::UID,
        virtual_sui_amt: u64,
        virtual_token_amt: u64,
        listing_fee: u64,
        swap_fee: u64,
        fee: 0x2::balance::Balance<0x2::sui::SUI>,
        config_id: 0x2::object::ID,
        pools_id: 0x2::object::ID,
        burn_manager_id: 0x2::object::ID,
    }

    struct PoolCreationReceipt has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        burn_proof_id: 0x2::object::ID,
    }

    struct BondingCurveListedEvent has copy, drop {
        object_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        sui_balance_val: u64,
        meme_balance_val: u64,
        virtual_sui_amt: u64,
        creator: address,
        ticker: 0x1::ascii::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::option::Option<0x2::url::Url>,
    }

    struct SwapEvent has copy, drop {
        bc_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        is_buy: bool,
        input_amount: u64,
        output_amount: u64,
        sui_reserve_val: u64,
        meme_reserve_val: u64,
        sender: address,
    }

    struct BondingCurveMigratedEvent has copy, drop {
        bc_id: 0x2::object::ID,
        meme_type: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
    }

    struct FeeEvent has copy, drop {
        bc_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct FeeWithdrawnEvent has copy, drop {
        configurator_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    public fun buy<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg8: &0x2::coin::CoinMetadata<T0>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg5);
        let v2 = &mut v1;
        take_fee<T0>(arg0, v2, v0);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        let (v4, v5) = get_reserves<T0>(arg0);
        let v6 = get_output_amount(v3, v4 + arg0.virtual_sui_amt, v5 + arg0.virtual_token_amt);
        let v7 = 0x2::balance::value<T0>(&arg0.meme_balance) - 100000000000000;
        if (400000000000000 - v7 + v6 >= 400000000000000) {
            let v9 = (((v7 as u128) * (v3 as u128) / (v6 as u128)) as u64);
            if (v9 < v3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v3 - v9), arg10), v0);
            };
            arg0.is_active = false;
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v1);
            let v10 = 0x2::balance::split<T0>(&mut arg0.meme_balance, v7);
            if (!arg0.migratedToDex) {
                migrate_to_dex<T0>(arg0, arg1, arg2, arg3, arg4, arg7, arg8, arg9, arg10);
            };
            let v11 = SwapEvent{
                bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
                meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                is_buy           : true,
                input_amount     : v9,
                output_amount    : v7,
                sui_reserve_val  : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance),
                meme_reserve_val : 0x2::balance::value<T0>(&arg0.meme_balance),
                sender           : v0,
            };
            0x2::event::emit<SwapEvent>(v11);
            0x2::coin::from_balance<T0>(v10, arg10)
        } else {
            assert!(v6 >= arg6, 1);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, v1);
            let (v12, v13) = get_reserves<T0>(arg0);
            assert!(v12 > 0 && v13 > 0, 5);
            let v14 = SwapEvent{
                bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
                meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                is_buy           : true,
                input_amount     : v3,
                output_amount    : v6,
                sui_reserve_val  : v12,
                meme_reserve_val : v13,
                sender           : v0,
            };
            0x2::event::emit<SwapEvent>(v14);
            0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme_balance, v6), arg10)
        }
    }

    public fun calculate_buy_input<T0>(arg0: &BondingCurve<T0>, arg1: u64) : u64 {
        let v0 = (((arg1 as u128) * ((0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) + arg0.virtual_sui_amt) as u128) / (((0x2::balance::value<T0>(&arg0.meme_balance) + arg0.virtual_token_amt) as u128) - (arg1 as u128))) as u64);
        v0 + ((((v0 as u128) * (arg0.swap_fee as u128) / 1000000) as u128) as u64)
    }

    public fun calculate_buy_output<T0>(arg0: &BondingCurve<T0>, arg1: u64) : u64 {
        get_output_amount(arg1 - ((((arg1 as u128) * (arg0.swap_fee as u128) / 1000000) as u128) as u64), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) + arg0.virtual_sui_amt, 0x2::balance::value<T0>(&arg0.meme_balance) + arg0.virtual_token_amt)
    }

    fun calculate_sqrt_price(arg0: u64, arg1: u64) : u128 {
        let v0 = 0x1::u128::sqrt((arg0 as u128) * 18446744073709551615 / (arg1 as u128) * 18446744073709551616);
        let v1 = if (v0 < 4295048016) {
            4295048016
        } else {
            v0
        };
        if (v1 > 79226673515401279992447579055) {
            79226673515401279992447579055
        } else {
            v1
        }
    }

    fun calculate_ticks(arg0: u128) : (u32, u32) {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(20)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(20))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(20)), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(20))))
    }

    fun get_coin_metadata_info<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : (0x1::ascii::String, 0x1::string::String, 0x1::string::String, 0x1::option::Option<0x2::url::Url>) {
        (0x2::coin::get_symbol<T0>(arg0), 0x2::coin::get_name<T0>(arg0), 0x2::coin::get_description<T0>(arg0), 0x2::coin::get_icon_url<T0>(arg0))
    }

    public fun get_info<T0>(arg0: &BondingCurve<T0>) : (u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.meme_balance), arg0.swap_fee, arg0.is_active)
    }

    fun get_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) + v0)) as u64)
    }

    fun get_reserves<T0>(arg0: &BondingCurve<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.meme_balance))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configurator{
            id                : 0x2::object::new(arg0),
            virtual_sui_amt   : 1000000000,
            virtual_token_amt : 9120000000000000,
            listing_fee       : 100,
            swap_fee          : 10000,
            fee               : 0x2::balance::zero<0x2::sui::SUI>(),
            config_id         : 0x2::object::id_from_address(@0xdaa46292632c3c4d8f31f23ea0f9b36a28ff3677e9684980e4438403a67a3d8f),
            pools_id          : 0x2::object::id_from_address(@0xf699e7f2276f5c9a75944b37a0c5b5d9ddfd2471bf6242483b03ab2887d198d0),
            burn_manager_id   : 0x2::object::id_from_address(@0x1d94aa32518d0cb00f9de6ed60d450c9a2090761f326752ffad06b2e9404f845),
        };
        0x2::transfer::share_object<Configurator>(v0);
    }

    public fun list<T0>(arg0: &mut Configurator, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 0);
        assert!(0x2::coin::get_decimals<T0>(arg2) == 9, 2);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg0.listing_fee, 3);
        0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::freeze::freeze_object<0x2::coin::TreasuryCap<T0>>(arg1, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(&mut v0, arg0.listing_fee));
        let v1 = BondingCurve<T0>{
            id                : 0x2::object::new(arg4),
            sui_balance       : v0,
            meme_balance      : 0x2::coin::mint_balance<T0>(&mut arg1, 500000000000000),
            fee               : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_amt   : arg0.virtual_sui_amt,
            virtual_token_amt : arg0.virtual_token_amt,
            is_active         : true,
            swap_fee          : arg0.swap_fee,
            creator           : 0x2::tx_context::sender(arg4),
            migratedToDex     : false,
        };
        let (v2, v3, v4, v5) = get_coin_metadata_info<T0>(arg2);
        let v6 = BondingCurveListedEvent{
            object_id        : 0x2::object::id<BondingCurve<T0>>(&v1),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sui_balance_val  : 0x2::balance::value<0x2::sui::SUI>(&v1.sui_balance),
            meme_balance_val : 0x2::balance::value<T0>(&v1.meme_balance),
            virtual_sui_amt  : v1.virtual_sui_amt,
            creator          : v1.creator,
            ticker           : v2,
            name             : v3,
            description      : v4,
            url              : v5,
        };
        0x2::event::emit<BondingCurveListedEvent>(v6);
        0x2::transfer::share_object<BondingCurve<T0>>(v1);
    }

    public fun migrate_to_dex<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut Configurator, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.migratedToDex == false, 7);
        assert!(arg0.is_active == false, 8);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig>(arg2) == arg1.config_id, 9);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools>(arg3) == arg1.pools_id, 10);
        assert!(0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager>(arg4) == arg1.burn_manager_id, 11);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v1 = 0x2::balance::value<T0>(&arg0.meme_balance);
        let v2 = calculate_sqrt_price(v0, v1);
        let (v3, v4) = calculate_ticks(v2);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, 0x2::sui::SUI>(arg2, arg3, 20, v2, 0x1::string::utf8(b"SUI-Token Full Range Pool"), v3, v4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.meme_balance, v1), arg8), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v0), arg8), arg6, arg5, true, arg7, arg8);
        let v8 = v5;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(v7));
        0x2::balance::join<T0>(&mut arg0.meme_balance, 0x2::coin::into_balance<T0>(v6));
        let v10 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp_v2(arg4, v8, arg8);
        let v11 = PoolCreationReceipt{
            id            : 0x2::object::new(arg8),
            pool_id       : v9,
            burn_proof_id : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v10),
        };
        arg0.migratedToDex = true;
        0x2::transfer::public_transfer<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(v10, arg0.creator);
        0x2::transfer::public_transfer<PoolCreationReceipt>(v11, arg0.creator);
        let v12 = BondingCurveMigratedEvent{
            bc_id     : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            pool_id   : v9,
        };
        0x2::event::emit<BondingCurveMigratedEvent>(v12);
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.is_active, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        let (v2, v3) = get_reserves<T0>(arg0);
        let v4 = 0x2::balance::value<T0>(&v1);
        let v5 = get_output_amount(v4, v3 + arg0.virtual_token_amt, v2 + arg0.virtual_sui_amt);
        assert!(v5 >= arg2, 1);
        0x2::balance::join<T0>(&mut arg0.meme_balance, v1);
        let v6 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v5);
        let v7 = &mut v6;
        take_fee<T0>(arg0, v7, v0);
        let (v8, v9) = get_reserves<T0>(arg0);
        assert!(v8 > 0 && v9 > 0, 5);
        let v10 = SwapEvent{
            bc_id            : 0x2::object::id<BondingCurve<T0>>(arg0),
            meme_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_buy           : false,
            input_amount     : v4,
            output_amount    : 0x2::balance::value<0x2::sui::SUI>(&v6),
            sui_reserve_val  : v8,
            meme_reserve_val : v9,
            sender           : v0,
        };
        0x2::event::emit<SwapEvent>(v10);
        0x2::coin::from_balance<0x2::sui::SUI>(v6, arg3)
    }

    fun take_fee<T0>(arg0: &mut BondingCurve<T0>, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: address) {
        let v0 = (((arg0.swap_fee as u128) * (0x2::balance::value<0x2::sui::SUI>(arg1) as u128) / 1000000) as u64);
        let v1 = FeeEvent{
            bc_id  : 0x2::object::id<BondingCurve<T0>>(arg0),
            amount : v0,
            sender : arg2,
        };
        0x2::event::emit<FeeEvent>(v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee, 0x2::balance::split<0x2::sui::SUI>(arg1, v0));
    }

    public fun update_dex_ids(arg0: &0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::admin::AdminCap, arg1: &mut Configurator, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        arg1.config_id = arg2;
        arg1.pools_id = arg3;
        arg1.burn_manager_id = arg4;
    }

    public fun update_listing_fee(arg0: &0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.listing_fee = arg2;
    }

    public fun update_swap_fee(arg0: &0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::admin::AdminCap, arg1: &mut Configurator, arg2: u64) {
        arg1.swap_fee = arg2;
    }

    public fun withdraw_fee(arg0: &0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::admin::AdminCap, arg1: &0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::admin::AdminAccess, arg2: &mut Configurator, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9d7b3ddc41b287fd071e93ad9127707b042d45d42ba300d69c56b6718d10c290::admin::get_addresses(arg1);
        let v1 = FeeWithdrawnEvent{
            configurator_id : 0x2::object::id<Configurator>(arg2),
            amount          : arg3,
            recipient       : v0,
            timestamp       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<FeeWithdrawnEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.fee, arg3), arg4), v0);
    }

    // decompiled from Move bytecode v6
}

