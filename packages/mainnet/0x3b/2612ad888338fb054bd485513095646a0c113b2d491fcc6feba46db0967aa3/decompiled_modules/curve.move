module 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::curve {
    struct BondingCurve<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        virtual_sui_amount: u64,
        token_balance: 0x2::balance::Balance<T0>,
        available_token_reserves: u64,
        total_supply: u64,
        creator: address,
        creator_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        open: bool,
        metadata_cap: 0x1::option::Option<0x2::coin_registry::MetadataCap<T0>>,
    }

    public fun total_supply<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.total_supply
    }

    public fun available_token_reserves<T0>(arg0: &BondingCurve<T0>) : u64 {
        arg0.available_token_reserves
    }

    public fun buy<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &mut BondingCurve<T0>, arg3: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let (v1, v2) = buy_returns<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::util::delete_or_return<0x2::sui::SUI>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
    }

    public fun buy_returns<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &mut BondingCurve<T0>, arg3: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        buy_returns_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    fun buy_returns_internal<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &mut BondingCurve<T0>, arg3: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_version(arg3);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_swaps_enabled(arg3);
        check_open_status<T0>(arg2);
        let v0 = get_price_per_token_scaled<T0>(arg2);
        let v1 = 0x2::balance::value<T0>(&arg2.token_balance);
        let v2 = arg2.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_balance);
        let v3 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_fee_amount(0x2::coin::value<0x2::sui::SUI>(&arg4), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::swap_fee_bps(arg3));
        let v4 = v3;
        let v5 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_fee_amount(0x2::coin::value<0x2::sui::SUI>(&arg4), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::creator_fee_bps(arg3));
        let v6 = v5;
        let v7 = v3 + v5;
        let v8 = v7;
        let v9 = 0x2::coin::value<0x2::sui::SUI>(&arg4) - v7;
        let v10 = v9;
        let v11 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_amount_out(v9, v2, v1);
        let v12 = v11;
        if (v11 > arg2.available_token_reserves) {
            let v13 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_amount_in(arg2.available_token_reserves, v2, v1);
            v10 = v13;
            let v14 = ((0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::swap_fee_bps(arg3) + 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::creator_fee_bps(arg3)) as u128);
            let v15 = (((v13 as u128) * 10000 / (10000 - v14)) as u64) - v13;
            v8 = v15;
            let v16 = (((v15 as u128) * (0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::swap_fee_bps(arg3) as u128) / v14) as u64);
            v4 = v16;
            v6 = v15 - v16;
            v12 = arg2.available_token_reserves;
        };
        assert!(v12 >= arg5, 1);
        let v17 = 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v8, arg6);
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v17, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg3));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v17, v4, arg6), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg3));
            0x2::balance::join<0x2::sui::SUI>(&mut arg2.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(v17));
        };
        0x2::coin::put<0x2::sui::SUI>(&mut arg2.sui_balance, 0x2::coin::split<0x2::sui::SUI>(&mut arg4, v10, arg6));
        let v18 = 0x2::coin::take<T0>(&mut arg2.token_balance, v12, arg6);
        arg2.available_token_reserves = arg2.available_token_reserves - 0x2::coin::value<T0>(&v18);
        let v19 = get_price_per_token_scaled<T0>(arg2);
        if (arg2.available_token_reserves == 0) {
            arg2.open = false;
            let v20 = &mut arg4;
            let v21 = move_curve<T0>(arg2, arg0, arg1, arg3, v20, arg6);
            if (0x2::coin::value<T0>(&v21) > 0) {
                0x2::coin::join<T0>(&mut v18, v21);
            } else {
                0x2::coin::destroy_zero<T0>(v21);
            };
        };
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_buy<T0>(get_id<T0>(arg2), v10 + v8, v12, v0, v19, 0x2::tx_context::sender(arg6), arg2.virtual_sui_amount, 0x2::balance::value<0x2::sui::SUI>(&arg2.sui_balance), 0x2::balance::value<T0>(&arg2.token_balance), arg2.available_token_reserves, v6);
        (arg4, v18)
    }

    public fun check_open_status<T0>(arg0: &BondingCurve<T0>) {
        assert!(arg0.open, 0);
    }

    public fun collect_creator_fees<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_withdraw_enabled(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.creator == v0, 4);
        let v1 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.creator_fees);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_creator_fee_collect(get_id<T0>(arg0), v0, 0x2::balance::value<0x2::sui::SUI>(&v1));
        0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2)
    }

    public fun create<T0>(arg0: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg1: 0x2::coin_registry::CurrencyInitializer<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg0) > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg0), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg5, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg0), arg6), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg0));
        };
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::util::delete_or_return<0x2::sui::SUI>(arg5, 0x2::tx_context::sender(arg6));
        0x2::transfer::share_object<BondingCurve<T0>>(create_bonding_curve<T0>(arg1, arg2, arg3, arg4, arg0, arg6));
    }

    public fun create_and_buy<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: 0x2::coin::TreasuryCap<T0>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        if (0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg2) > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg2), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg2), arg9), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg2));
        };
        let v0 = create_bonding_curve<T0>(arg3, arg4, arg5, arg6, arg2, arg9);
        let v1 = &mut v0;
        buy<T0>(arg0, arg1, v1, arg2, arg7, arg8, arg9);
        0x2::transfer::share_object<BondingCurve<T0>>(v0);
    }

    public fun create_and_buy_returns<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg3: 0x2::coin_registry::CurrencyInitializer<T0>, arg4: 0x2::coin::TreasuryCap<T0>, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        if (0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg2) > 0) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg2), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::listing_fee(arg2), arg9), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg2));
        };
        let v0 = create_bonding_curve<T0>(arg3, arg4, arg5, arg6, arg2, arg9);
        let v1 = &mut v0;
        let (v2, v3) = buy_returns<T0>(arg0, arg1, v1, arg2, arg7, arg8, arg9);
        0x2::transfer::share_object<BondingCurve<T0>>(v0);
        (v2, v3)
    }

    public(friend) fun create_bonding_curve<T0>(arg0: 0x2::coin_registry::CurrencyInitializer<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg5: &mut 0x2::tx_context::TxContext) : BondingCurve<T0> {
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_version(arg4);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_create_enabled(arg4);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 2);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 3);
        let v0 = 0x2::coin::mint_balance<T0>(&mut arg1, 1000000000000000);
        0x2::coin_registry::make_supply_burn_only_init<T0>(&mut arg0, arg1);
        let v1 = 0x2::balance::value<T0>(&v0);
        let v2 = BondingCurve<T0>{
            id                       : 0x2::object::new(arg5),
            sui_balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            virtual_sui_amount       : 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::virtual_sui_amount(arg4),
            token_balance            : v0,
            available_token_reserves : 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::curve_supply_bps(arg4) * v1 / 10000,
            total_supply             : v1,
            creator                  : 0x2::tx_context::sender(arg5),
            creator_fees             : 0x2::balance::zero<0x2::sui::SUI>(),
            open                     : true,
            metadata_cap             : 0x1::option::some<0x2::coin_registry::MetadataCap<T0>>(0x2::coin_registry::finalize<T0>(arg0, arg5)),
        };
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_curve_create(get_id<T0>(&v2), 0x2::tx_context::sender(arg5), arg2, arg3);
        v2
    }

    public fun creator<T0>(arg0: &BondingCurve<T0>) : address {
        arg0.creator
    }

    public fun creator_fees<T0>(arg0: &BondingCurve<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_fees)
    }

    public fun get_id<T0>(arg0: &BondingCurve<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun get_price_per_token_scaled<T0>(arg0: &BondingCurve<T0>) : u64 {
        if (0x2::balance::value<T0>(&arg0.token_balance) == 0) {
            return 0
        };
        ((((arg0.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)) as u128) * 100000000 / (0x2::balance::value<T0>(&arg0.token_balance) as u128)) as u64)
    }

    public fun is_open<T0>(arg0: &BondingCurve<T0>) : bool {
        arg0.open
    }

    public(friend) fun move_curve<T0>(arg0: &mut BondingCurve<T0>, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg2: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg3: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.open, 0);
        assert!(arg0.available_token_reserves == 0, 0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        let v1 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v0, arg5);
        if (0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::migration_fee_bps(arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, (((v0 as u128) * (0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::migration_fee_bps(arg3) as u128) / 10000) as u64), arg5), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg3));
        };
        let v2 = 0x2::balance::value<T0>(&arg0.token_balance);
        let v3 = 0x1::u128::sqrt(((((0x2::coin::value<0x2::sui::SUI>(&v1) as u256) + (arg0.virtual_sui_amount as u256)) * 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q128() / (v2 as u256)) as u128));
        let v4 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::get_tick_at_sqrt_price(((0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::constants::q128() * (0x2::coin::value<0x2::sui::SUI>(&v1) as u256) / ((arg0.total_supply - v2) as u256) * (v3 as u256)) as u128));
        let v5 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::tick_spacing(arg2);
        let v6 = if (0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::is_neg(v4)) {
            let v7 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::abs_u32(v4);
            let v8 = v7 % v5;
            if (v8 == 0) {
                v4
            } else {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::neg_from(v7 + v5 - v8)
            }
        } else {
            let v9 = 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(v4);
            let v10 = v9 % v5;
            if (v10 == 0) {
                v4
            } else {
                0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::from(v9 + v5 - v10)
            }
        };
        let v11 = 0x2::coin::value<0x2::sui::SUI>(arg4);
        let (v12, v13, v14, v15) = if (v11 > 0) {
            let (v16, v17, v18, v19) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::create::create_pool_dynamic_and_buy<T0>(arg1, arg2, 6, arg0.total_supply / 0x1::u64::pow(10, 6), v3, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(v6), 0x2::coin::take<T0>(&mut arg0.token_balance, v2, arg5), v1, false, true, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg3), arg0.creator, 0x2::coin::split<0x2::sui::SUI>(arg4, v11, arg5), arg5);
            (v19, v16, v17, v18)
        } else {
            let (v20, v21, v22) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::create::create_pool_dynamic<T0>(arg1, arg2, 6, arg0.total_supply / 0x1::u64::pow(10, 6), v3, 0x3637b7b60978ef4389124f7683456f0050ab015a0590d52b6e6cadb342af34a::i32::as_u32(v6), 0x2::coin::take<T0>(&mut arg0.token_balance, v2, arg5), v1, false, true, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg3), arg0.creator, arg5);
            (0x2::coin::zero<T0>(arg5), v20, v21, v22)
        };
        0x2::balance::join<T0>(&mut arg0.token_balance, 0x2::coin::into_balance<T0>(v14));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v15, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg3));
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_migrate(get_id<T0>(arg0), v13);
        arg0.open = false;
        v12
    }

    public fun sell<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_returns<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun sell_returns<T0>(arg0: &mut BondingCurve<T0>, arg1: &0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::LaunchConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_version(arg1);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::enforce_swaps_enabled(arg1);
        check_open_status<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_amount_out(v0, 0x2::balance::value<T0>(&arg0.token_balance), arg0.virtual_sui_amount + 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance));
        let v2 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_fee_amount(v1, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::swap_fee_bps(arg1));
        let v3 = 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math::get_fee_amount(v1, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::creator_fee_bps(arg1));
        arg0.available_token_reserves = arg0.available_token_reserves + v0;
        0x2::coin::put<T0>(&mut arg0.token_balance, arg2);
        let v4 = 0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, v1, arg4);
        let v5 = 0x2::coin::split<0x2::sui::SUI>(&mut v4, v2 + v3, arg4);
        if (v3 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg1));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v5, v2, arg4), 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::config::treasury_address(arg1));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_fees, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&v4) >= arg3, 1);
        0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::events::emit_sell<T0>(get_id<T0>(arg0), 0x2::coin::value<0x2::sui::SUI>(&v4), v0, get_price_per_token_scaled<T0>(arg0), get_price_per_token_scaled<T0>(arg0), 0x2::tx_context::sender(arg4), arg0.virtual_sui_amount, 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance), 0x2::balance::value<T0>(&arg0.token_balance), arg0.available_token_reserves, v3);
        v4
    }

    // decompiled from Move bytecode v6
}

