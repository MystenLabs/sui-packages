module 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap {
    struct LPCoin<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct LiquidityPool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_x_reserve: 0x2::balance::Balance<T0>,
        coin_y_reserve: 0x2::balance::Balance<T1>,
        lp_coin_reserve: 0x2::balance::Balance<LPCoin<T0, T1>>,
        lp_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
        last_block_timestamp: u64,
        last_price_x_cumulative: u128,
        last_price_y_cumulative: u128,
        k_last: u128,
        locked: bool,
    }

    struct AdminData has copy, drop, store {
        dao_fee_to: address,
        admin_address: address,
        dao_fee: u64,
        swap_fee: u64,
        dao_fee_on: bool,
        is_pause: bool,
    }

    struct LiquidityPools has key {
        id: 0x2::object::UID,
        admin_data: AdminData,
        pair_info: PairInfo,
    }

    struct PairMeta has copy, drop, store {
        coin_x: 0x1::ascii::String,
        coin_y: 0x1::ascii::String,
    }

    struct PairInfo has copy, drop, store {
        pair_list: vector<PairMeta>,
    }

    struct PairCreatedEvent<phantom T0, phantom T1> has copy, drop {
        meta: PairMeta,
    }

    struct MintEvent<phantom T0, phantom T1> has copy, drop {
        amount_x: u64,
        amount_y: u64,
        liquidity: u64,
    }

    struct BurnEvent<phantom T0, phantom T1> has copy, drop {
        amount_x: u64,
        amount_y: u64,
        liquidity: u64,
    }

    struct SwapEvent<phantom T0, phantom T1> has copy, drop {
        amount_x_in: u64,
        amount_y_in: u64,
        amount_x_out: u64,
        amount_y_out: u64,
    }

    struct SyncEvent<phantom T0, phantom T1> has copy, drop {
        reserve_x: u64,
        reserve_y: u64,
        last_price_x_cumulative: u128,
        last_price_y_cumulative: u128,
    }

    struct FlashSwapEvent<phantom T0, phantom T1> has copy, drop {
        loan_coin_x: u64,
        loan_coin_y: u64,
        repay_coin_x: u64,
        repay_coin_y: u64,
    }

    struct FlashSwap<phantom T0, phantom T1> {
        loan_coin_x: u64,
        loan_coin_y: u64,
    }

    public fun swap<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_lp_unlocked<T0, T1>(arg0);
        assert_not_paused(arg0);
        let (v0, v1) = get_pool<T0, T1>(arg0);
        let v2 = 0x2::balance::value<T0>(&arg2);
        let v3 = 0x2::balance::value<T1>(&arg4);
        assert!(v2 > 0 || v3 > 0, 110);
        assert!(arg3 > 0 || arg5 > 0, 111);
        let (v4, v5) = get_reserves_size<T0, T1>(v0);
        0x2::balance::join<T0>(&mut v0.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut v0.coin_y_reserve, arg4);
        let v6 = 0x2::balance::split<T0>(&mut v0.coin_x_reserve, arg3);
        let v7 = 0x2::balance::split<T1>(&mut v0.coin_y_reserve, arg5);
        let (v8, v9) = get_reserves_size<T0, T1>(v0);
        assert_k_increase(v1, v8, v9, v2, v3, v4, v5);
        update_internal<T0, T1>(v0, arg1, v8, v9, v4, v5);
        let v10 = SwapEvent<T0, T1>{
            amount_x_in  : v2,
            amount_y_in  : v3,
            amount_x_out : arg3,
            amount_y_out : arg5,
        };
        0x2::event::emit<SwapEvent<T0, T1>>(v10);
        (v6, v7)
    }

    public fun add_liquidity<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LPCoin<T0, T1>> {
        assert!(0x2::coin::value<T0>(&arg2) >= arg4 && arg4 >= arg6 && arg6 > 0, 108);
        assert!(0x2::coin::value<T1>(&arg3) >= arg5 && arg5 >= arg7 && arg7 > 0, 109);
        let (v0, v1) = calc_optimal_coin_values<T0, T1>(arg0, arg4, arg5, arg6, arg7);
        let v2 = 0x2::coin::from_balance<LPCoin<T0, T1>>(mint<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg8)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v1, arg8))), arg8);
        return_remaining_coin<T0>(arg2, arg8);
        return_remaining_coin<T1>(arg3, arg8);
        v2
    }

    public entry fun add_liquidity_entry<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = check_pair_exist<T0, T1>(arg0);
        if (!v0) {
            create_pair<T0, T1>(arg0, arg8);
        };
        let v1 = add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(v1, 0x2::tx_context::sender(arg8));
    }

    fun assert_k_increase(arg0: AdminData, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = arg0.swap_fee;
        let v1 = (arg1 as u128) * 10000 - (arg3 as u128) * (v0 as u128);
        let v2 = (arg2 as u128) * 10000 - (arg4 as u128) * (v0 as u128);
        let v3 = (arg5 as u128) * (arg6 as u128);
        let v4 = 100000000;
        if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::is_overflow_mul(v1, v2) || 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::is_overflow_mul(v3, v4)) {
            assert!((v1 as u256) * (v2 as u256) >= (v3 as u256) * (v4 as u256), 112);
        } else {
            assert!(v1 * v2 >= v3 * v4, 112);
        };
    }

    fun assert_lp_unlocked<T0, T1>(arg0: &mut LiquidityPools) {
        assert!(check_pair_exist<T0, T1>(arg0), 116);
        let (v0, _) = get_pool<T0, T1>(arg0);
        assert!(!v0.locked, 118);
    }

    fun assert_not_paused(arg0: &mut LiquidityPools) {
        assert!(!arg0.admin_data.is_pause, 120);
    }

    fun assert_paused(arg0: &mut LiquidityPools) {
        assert!(arg0.admin_data.is_pause, 120);
    }

    public fun burn<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<LPCoin<T0, T1>>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert_lp_unlocked<T0, T1>(arg0);
        assert_not_paused(arg0);
        let v0 = mint_fee_internal<T0, T1>(arg0);
        let (v1, _) = get_pool<T0, T1>(arg0);
        let v3 = 0x2::balance::value<LPCoin<T0, T1>>(&arg2);
        let (v4, v5) = get_reserves_size<T0, T1>(v1);
        let v6 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&v1.lp_supply);
        let v7 = (((v3 as u128) * (v4 as u128) / (v6 as u128)) as u64);
        let v8 = (((v3 as u128) * (v5 as u128) / (v6 as u128)) as u64);
        let v9 = 0x2::balance::split<T0>(&mut v1.coin_x_reserve, v7);
        let v10 = 0x2::balance::split<T1>(&mut v1.coin_y_reserve, v8);
        let (v11, v12) = get_reserves_size<T0, T1>(v1);
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut v1.lp_supply, arg2);
        update_internal<T0, T1>(v1, arg1, v11, v12, v4, v5);
        if (v0) {
            v1.k_last = (v11 as u128) * (v12 as u128);
        };
        let v13 = MintEvent<T0, T1>{
            amount_x  : v7,
            amount_y  : v8,
            liquidity : v3,
        };
        0x2::event::emit<MintEvent<T0, T1>>(v13);
        (v9, v10)
    }

    public fun calc_optimal_coin_values<T0, T1>(arg0: &mut LiquidityPools, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let (v0, _) = get_pool<T0, T1>(arg0);
        let (v2, v3) = get_reserves_size<T0, T1>(v0);
        if (v2 == 0 && v3 == 0) {
            (arg1, arg2)
        } else {
            let v6 = 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::quote(arg1, v2, v3);
            if (v6 <= arg2) {
                assert!(v6 >= arg4, 109);
                (arg1, v6)
            } else {
                let v7 = 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::quote(arg2, v3, v2);
                assert!(v7 <= arg1, 102);
                assert!(v7 >= arg3, 108);
                (v7, arg2)
            }
        }
    }

    public fun check_pair_exist<T0, T1>(arg0: &mut LiquidityPools) : bool {
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&mut arg0.id, get_lp_name<T0, T1>())
    }

    public fun create_pair<T0, T1>(arg0: &mut LiquidityPools, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>(), 119);
        let v0 = check_pair_exist<T0, T1>(arg0);
        assert!(!v0, 115);
        assert_not_paused(arg0);
        let v1 = LPCoin<T0, T1>{dummy_field: false};
        let v2 = LiquidityPool<T0, T1>{
            id                      : 0x2::object::new(arg1),
            coin_x_reserve          : 0x2::balance::zero<T0>(),
            coin_y_reserve          : 0x2::balance::zero<T1>(),
            lp_coin_reserve         : 0x2::balance::zero<LPCoin<T0, T1>>(),
            lp_supply               : 0x2::balance::create_supply<LPCoin<T0, T1>>(v1),
            last_block_timestamp    : 0,
            last_price_x_cumulative : 0,
            last_price_y_cumulative : 0,
            k_last                  : 0,
            locked                  : false,
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, get_lp_name<T0, T1>(), v2);
        let v3 = PairMeta{
            coin_x : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin_y : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x1::vector::push_back<PairMeta>(&mut arg0.pair_info.pair_list, v3);
        let v4 = PairCreatedEvent<T0, T1>{meta: v3};
        0x2::event::emit<PairCreatedEvent<T0, T1>>(v4);
    }

    public fun flash_swap<T0, T1>(arg0: &mut LiquidityPools, arg1: u64, arg2: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwap<T0, T1>) {
        assert!(0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>(), 119);
        assert!(arg1 > 0 || arg2 > 0, 117);
        assert_lp_unlocked<T0, T1>(arg0);
        assert_not_paused(arg0);
        let (v0, _) = get_pool<T0, T1>(arg0);
        assert!(0x2::balance::value<T0>(&v0.coin_x_reserve) >= arg1 && 0x2::balance::value<T1>(&v0.coin_y_reserve) >= arg2, 104);
        v0.locked = true;
        let v2 = FlashSwap<T0, T1>{
            loan_coin_x : arg1,
            loan_coin_y : arg2,
        };
        (0x2::balance::split<T0>(&mut v0.coin_x_reserve, arg1), 0x2::balance::split<T1>(&mut v0.coin_y_reserve, arg2), v2)
    }

    public fun get_admin_data(arg0: &mut LiquidityPools) : (u64, u64, bool, bool) {
        (arg0.admin_data.swap_fee, arg0.admin_data.dao_fee, arg0.admin_data.dao_fee_on, arg0.admin_data.is_pause)
    }

    public fun get_amounts_in<T0, T1>(arg0: &mut LiquidityPools, arg1: u64) : u64 {
        if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let (v1, v2) = get_pool<T0, T1>(arg0);
            let v3 = v2;
            let (v4, v5) = get_reserves_size<T0, T1>(v1);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_in(arg1, v4, v5, v3.swap_fee)
        } else {
            let (v6, v7) = get_pool<T1, T0>(arg0);
            let v8 = v7;
            let (v9, v10) = get_reserves_size<T1, T0>(v6);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_in(arg1, v10, v9, v8.swap_fee)
        }
    }

    public fun get_amounts_in_2_pair<T0, T1, T2>(arg0: &mut LiquidityPools, arg1: u64) : u64 {
        let v0 = if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T1, T2>()) {
            let (v1, v2) = get_pool<T1, T2>(arg0);
            let v3 = v2;
            let (v4, v5) = get_reserves_size<T1, T2>(v1);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_in(arg1, v4, v5, v3.swap_fee)
        } else {
            let (v6, v7) = get_pool<T2, T1>(arg0);
            let v8 = v7;
            let (v9, v10) = get_reserves_size<T2, T1>(v6);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_in(arg1, v10, v9, v8.swap_fee)
        };
        if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let (v12, v13) = get_pool<T0, T1>(arg0);
            let v14 = v13;
            let (v15, v16) = get_reserves_size<T0, T1>(v12);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_in(v0, v15, v16, v14.swap_fee)
        } else {
            let (v17, v18) = get_pool<T1, T0>(arg0);
            let v19 = v18;
            let (v20, v21) = get_reserves_size<T1, T0>(v17);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_in(v0, v21, v20, v19.swap_fee)
        }
    }

    public fun get_amounts_out<T0, T1>(arg0: &mut LiquidityPools, arg1: u64) : u64 {
        if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let (v1, v2) = get_pool<T0, T1>(arg0);
            let v3 = v2;
            let (v4, v5) = get_reserves_size<T0, T1>(v1);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_out(arg1, v4, v5, v3.swap_fee)
        } else {
            let (v6, v7) = get_pool<T1, T0>(arg0);
            let v8 = v7;
            let (v9, v10) = get_reserves_size<T1, T0>(v6);
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_out(arg1, v10, v9, v8.swap_fee)
        }
    }

    public fun get_lp_name<T0, T1>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<LPCoin<T0, T1>>())
    }

    public fun get_pair_list(arg0: &mut LiquidityPools) : vector<PairMeta> {
        arg0.pair_info.pair_list
    }

    public fun get_pool<T0, T1>(arg0: &mut LiquidityPools) : (&mut LiquidityPool<T0, T1>, AdminData) {
        (0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, LiquidityPool<T0, T1>>(&mut arg0.id, get_lp_name<T0, T1>()), arg0.admin_data)
    }

    public fun get_reserves_size<T0, T1>(arg0: &LiquidityPool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.coin_x_reserve), 0x2::balance::value<T1>(&arg0.coin_y_reserve))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminData{
            dao_fee_to    : @0x2ab6bc284091a0dd94f9533f756549fe7583e51c79d0b10bacd5d9816ccf8f74,
            admin_address : @0x2ab6bc284091a0dd94f9533f756549fe7583e51c79d0b10bacd5d9816ccf8f74,
            dao_fee       : 5,
            swap_fee      : 30,
            dao_fee_on    : true,
            is_pause      : false,
        };
        let v1 = PairInfo{pair_list: 0x1::vector::empty<PairMeta>()};
        let v2 = LiquidityPools{
            id         : 0x2::object::new(arg0),
            admin_data : v0,
            pair_info  : v1,
        };
        0x2::transfer::share_object<LiquidityPools>(v2);
    }

    public fun mint<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<LPCoin<T0, T1>> {
        assert_lp_unlocked<T0, T1>(arg0);
        assert_not_paused(arg0);
        let v0 = mint_fee_internal<T0, T1>(arg0);
        let (v1, _) = get_pool<T0, T1>(arg0);
        let v3 = 0x2::balance::value<T0>(&arg2);
        let v4 = 0x2::balance::value<T1>(&arg3);
        let (v5, v6) = get_reserves_size<T0, T1>(v1);
        let v7 = 0x2::balance::supply_value<LPCoin<T0, T1>>(&v1.lp_supply);
        0x2::balance::join<T0>(&mut v1.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut v1.coin_y_reserve, arg3);
        let (v8, v9) = get_reserves_size<T0, T1>(v1);
        let v10 = if (v7 == 0) {
            0x2::balance::join<LPCoin<T0, T1>>(&mut v1.lp_coin_reserve, 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v1.lp_supply, 1000));
            0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::sqrt(v3, v4) - 1000
        } else {
            0x2::math::min((((v3 as u128) * (v7 as u128) / (v5 as u128)) as u64), (((v4 as u128) * (v7 as u128) / (v6 as u128)) as u64))
        };
        assert!(v10 > 0, 106);
        let v11 = 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v1.lp_supply, v10);
        update_internal<T0, T1>(v1, arg1, v8, v9, v5, v6);
        if (v0) {
            v1.k_last = (v8 as u128) * (v9 as u128);
        };
        let v12 = MintEvent<T0, T1>{
            amount_x  : v3,
            amount_y  : v4,
            liquidity : v10,
        };
        0x2::event::emit<MintEvent<T0, T1>>(v12);
        v11
    }

    fun mint_fee_internal<T0, T1>(arg0: &mut LiquidityPools) : bool {
        let (v0, v1) = get_pool<T0, T1>(arg0);
        let v2 = v1;
        let v3 = v2.dao_fee_on;
        let v4 = v0.k_last;
        if (v3) {
            if (v4 != 0) {
                let (v5, v6) = get_reserves_size<T0, T1>(v0);
                let v7 = 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::sqrt(v5, v6);
                let v8 = (0x2::math::sqrt_u128(v4) as u64);
                let v9 = (0x2::balance::supply_value<LPCoin<T0, T1>>(&v0.lp_supply) as u128);
                if (v7 > v8) {
                    let v10 = ((v7 - v8) as u128);
                    if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::is_overflow_mul(v9, v10)) {
                        let v11 = (((v9 as u256) * (v10 as u256) / ((v7 as u256) * (v2.dao_fee as u256) + (v8 as u256))) as u64);
                        if (v11 > 0) {
                            0x2::balance::join<LPCoin<T0, T1>>(&mut v0.lp_coin_reserve, 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v0.lp_supply, v11));
                        };
                    } else {
                        let v12 = ((v9 * v10 / ((v7 as u128) * (v2.dao_fee as u128) + (v8 as u128))) as u64);
                        if (v12 > 0) {
                            0x2::balance::join<LPCoin<T0, T1>>(&mut v0.lp_coin_reserve, 0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut v0.lp_supply, v12));
                        };
                    };
                };
            };
        } else if (v4 != 0) {
            v0.k_last = 0;
        };
        v3
    }

    public entry fun pause(arg0: &mut LiquidityPools, arg1: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        assert!(arg0.admin_data.admin_address == 0x2::tx_context::sender(arg1), 103);
        arg0.admin_data.is_pause = true;
    }

    public fun pay_flash_swap<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwap<T0, T1>) {
        assert!(0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>(), 119);
        assert_not_paused(arg0);
        let FlashSwap {
            loan_coin_x : v0,
            loan_coin_y : v1,
        } = arg4;
        let v2 = 0x2::balance::value<T0>(&arg2);
        let v3 = 0x2::balance::value<T1>(&arg3);
        assert!(v2 > 0 || v3 > 0, 117);
        let (v4, v5) = get_pool<T0, T1>(arg0);
        let v6 = 0x2::balance::value<T0>(&v4.coin_x_reserve) + v0;
        let v7 = 0x2::balance::value<T1>(&v4.coin_y_reserve) + v1;
        0x2::balance::join<T0>(&mut v4.coin_x_reserve, arg2);
        0x2::balance::join<T1>(&mut v4.coin_y_reserve, arg3);
        let v8 = 0x2::balance::value<T0>(&v4.coin_x_reserve);
        let v9 = 0x2::balance::value<T1>(&v4.coin_y_reserve);
        assert_k_increase(v5, v8, v9, v2, v3, v6, v7);
        update_internal<T0, T1>(v4, arg1, v8, v9, v6, v7);
        v4.locked = false;
        let v10 = FlashSwapEvent<T0, T1>{
            loan_coin_x  : v0,
            loan_coin_y  : v1,
            repay_coin_x : v2,
            repay_coin_y : v3,
        };
        0x2::event::emit<FlashSwapEvent<T0, T1>>(v10);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<LPCoin<T0, T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<LPCoin<T0, T1>>(&arg2) >= arg3, 110);
        let (v0, v1) = burn<T0, T1>(arg0, arg1, 0x2::coin::into_balance<LPCoin<T0, T1>>(0x2::coin::split<LPCoin<T0, T1>>(&mut arg2, arg3, arg6)));
        let v2 = 0x2::coin::from_balance<T0>(v0, arg6);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg6);
        assert!(0x2::coin::value<T0>(&v2) >= arg4, 108);
        assert!(0x2::coin::value<T1>(&v3) >= arg5, 109);
        return_remaining_coin<LPCoin<T0, T1>>(arg2, arg6);
        (v2, v3)
    }

    public entry fun remove_liquidity_entry<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<LPCoin<T0, T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun return_remaining_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public entry fun set_admin_address(arg0: &mut LiquidityPools, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_data.admin_address == 0x2::tx_context::sender(arg2), 103);
        arg0.admin_data.admin_address = arg1;
    }

    public entry fun set_dao_fee(arg0: &mut LiquidityPools, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_data.admin_address == 0x2::tx_context::sender(arg2), 103);
        if (arg1 == 0) {
            arg0.admin_data.dao_fee_on = false;
        } else {
            arg0.admin_data.dao_fee_on = true;
            arg0.admin_data.dao_fee = arg1;
        };
    }

    public entry fun set_dao_fee_to(arg0: &mut LiquidityPools, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_data.admin_address == 0x2::tx_context::sender(arg2), 103);
        arg0.admin_data.dao_fee_to = arg1;
    }

    public entry fun set_swap_fee(arg0: &mut LiquidityPools, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_data.admin_address == 0x2::tx_context::sender(arg2), 103);
        arg0.admin_data.swap_fee = arg1;
    }

    public fun swap_balance_for_balance<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = get_pool<T0, T1>(arg0);
        let v2 = v1;
        let v3 = 0x2::balance::value<T0>(&arg2);
        let v4 = 0x2::balance::value<T1>(&arg3);
        assert!(v3 > 0 && v4 == 0 || v3 == 0 || v3 > 0, 121);
        if (v3 > 0) {
            let (v7, v8) = get_reserves_size<T0, T1>(v0);
            swap<T0, T1>(arg0, arg1, arg2, 0, arg3, 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_out(v3, v7, v8, v2.swap_fee))
        } else {
            let (v9, v10) = get_reserves_size<T0, T1>(v0);
            swap<T0, T1>(arg0, arg1, arg2, 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::get_amount_out(v4, v10, v9, v2.swap_fee), arg3, 0)
        }
    }

    public fun swap_coins_for_coins<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = swap_balance_for_balance<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3));
        (0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::from_balance<T1>(v1, arg4))
    }

    public entry fun swap_coins_for_exact_coins_2_pair_entry<T0, T1, T2>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_amounts_in_2_pair<T0, T1, T2>(arg0, arg3);
        assert!(v0 <= arg4, 110);
        let v1 = if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let v2 = 0x2::coin::split<T0>(&mut arg2, v0, arg5);
            let v3 = 0x2::coin::zero<T1>(arg5);
            let (v4, v5) = swap_coins_for_coins<T0, T1>(arg0, arg1, v2, v3, arg5);
            0x2::coin::destroy_zero<T0>(v4);
            return_remaining_coin<T0>(arg2, arg5);
            v5
        } else {
            let v6 = 0x2::coin::split<T0>(&mut arg2, v0, arg5);
            let v7 = 0x2::coin::zero<T1>(arg5);
            let (v8, v9) = swap_coins_for_coins<T1, T0>(arg0, arg1, v7, v6, arg5);
            0x2::coin::destroy_zero<T0>(v9);
            return_remaining_coin<T0>(arg2, arg5);
            v8
        };
        let v10 = if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T1, T2>()) {
            let v11 = 0x2::coin::zero<T2>(arg5);
            let (v12, v13) = swap_coins_for_coins<T1, T2>(arg0, arg1, v1, v11, arg5);
            0x2::coin::destroy_zero<T1>(v12);
            v13
        } else {
            let v14 = 0x2::coin::zero<T2>(arg5);
            let (v15, v16) = swap_coins_for_coins<T2, T1>(arg0, arg1, v14, v1, arg5);
            0x2::coin::destroy_zero<T1>(v16);
            v15
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v10, 0x2::tx_context::sender(arg5));
    }

    public entry fun swap_coins_for_exact_coins_entry<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_amounts_in<T0, T1>(arg0, arg3);
        assert!(v0 <= arg4, 110);
        let v1 = 0x2::coin::split<T0>(&mut arg2, v0, arg5);
        if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let v2 = 0x2::coin::zero<T1>(arg5);
            let (v3, v4) = swap_coins_for_coins<T0, T1>(arg0, arg1, v1, v2, arg5);
            0x2::coin::destroy_zero<T0>(v3);
            return_remaining_coin<T0>(arg2, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg5));
        } else {
            let v5 = 0x2::coin::zero<T1>(arg5);
            let (v6, v7) = swap_coins_for_coins<T1, T0>(arg0, arg1, v5, v1, arg5);
            0x2::coin::destroy_zero<T0>(v7);
            return_remaining_coin<T0>(arg2, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, 0x2::tx_context::sender(arg5));
        };
    }

    public entry fun swap_exact_coins_for_coins_2_pair_entry<T0, T1, T2>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let v1 = 0x2::coin::split<T0>(&mut arg2, arg3, arg5);
            let v2 = 0x2::coin::zero<T1>(arg5);
            let (v3, v4) = swap_coins_for_coins<T0, T1>(arg0, arg1, v1, v2, arg5);
            0x2::coin::destroy_zero<T0>(v3);
            return_remaining_coin<T0>(arg2, arg5);
            v4
        } else {
            let v5 = 0x2::coin::split<T0>(&mut arg2, arg3, arg5);
            let v6 = 0x2::coin::zero<T1>(arg5);
            let (v7, v8) = swap_coins_for_coins<T1, T0>(arg0, arg1, v6, v5, arg5);
            0x2::coin::destroy_zero<T0>(v8);
            return_remaining_coin<T0>(arg2, arg5);
            v7
        };
        let v9 = if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T1, T2>()) {
            let v10 = 0x2::coin::zero<T2>(arg5);
            let (v11, v12) = swap_coins_for_coins<T1, T2>(arg0, arg1, v0, v10, arg5);
            let v9 = v12;
            0x2::coin::destroy_zero<T1>(v11);
            assert!(0x2::coin::value<T2>(&v9) >= arg4, 111);
            v9
        } else {
            let v13 = 0x2::coin::zero<T2>(arg5);
            let (v14, v15) = swap_coins_for_coins<T2, T1>(arg0, arg1, v13, v0, arg5);
            let v9 = v14;
            0x2::coin::destroy_zero<T1>(v15);
            assert!(0x2::coin::value<T2>(&v9) >= arg4, 111);
            v9
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v9, 0x2::tx_context::sender(arg5));
    }

    public entry fun swap_exact_coins_for_coins_entry<T0, T1>(arg0: &mut LiquidityPools, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::compare<T0, T1>()) {
            let v0 = 0x2::coin::split<T0>(&mut arg2, arg3, arg5);
            let v1 = 0x2::coin::zero<T1>(arg5);
            let (v2, v3) = swap_coins_for_coins<T0, T1>(arg0, arg1, v0, v1, arg5);
            let v4 = v3;
            0x2::coin::destroy_zero<T0>(v2);
            assert!(0x2::coin::value<T1>(&v4) >= arg4, 111);
            return_remaining_coin<T0>(arg2, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, 0x2::tx_context::sender(arg5));
        } else {
            let v5 = 0x2::coin::split<T0>(&mut arg2, arg3, arg5);
            let v6 = 0x2::coin::zero<T1>(arg5);
            let (v7, v8) = swap_coins_for_coins<T1, T0>(arg0, arg1, v6, v5, arg5);
            let v9 = v7;
            0x2::coin::destroy_zero<T0>(v8);
            assert!(0x2::coin::value<T1>(&v9) >= arg4, 111);
            return_remaining_coin<T0>(arg2, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, 0x2::tx_context::sender(arg5));
        };
    }

    public entry fun unpause(arg0: &mut LiquidityPools, arg1: &mut 0x2::tx_context::TxContext) {
        assert_paused(arg0);
        assert!(arg0.admin_data.admin_address == 0x2::tx_context::sender(arg1), 103);
        arg0.admin_data.is_pause = false;
    }

    fun update_internal<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = ((v0 - arg0.last_block_timestamp) as u128);
        if (v1 > 0 && arg4 != 0 && arg5 != 0) {
            arg0.last_price_x_cumulative = 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::overflow_add(arg0.last_price_x_cumulative, 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::uq64x64::to_u128(0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::uq64x64::fraction(arg5, arg4)) * v1);
            arg0.last_price_y_cumulative = 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::kojikiswap_library::overflow_add(arg0.last_price_y_cumulative, 0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::uq64x64::to_u128(0x8d88e12c707e60fe323c2ff3af8b259d226e2f4c7f9fe0c25da3fb4782dd82b0::uq64x64::fraction(arg4, arg5)) * v1);
        };
        arg0.last_block_timestamp = v0;
        let v2 = SyncEvent<T0, T1>{
            reserve_x               : arg2,
            reserve_y               : arg3,
            last_price_x_cumulative : arg0.last_price_x_cumulative,
            last_price_y_cumulative : arg0.last_price_y_cumulative,
        };
        0x2::event::emit<SyncEvent<T0, T1>>(v2);
    }

    public entry fun withdraw_dao_fee<T0, T1>(arg0: &mut LiquidityPools, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_data.dao_fee_to == 0x2::tx_context::sender(arg1), 103);
        let (v0, _) = get_pool<T0, T1>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(0x2::balance::split<LPCoin<T0, T1>>(&mut v0.lp_coin_reserve, 0x2::balance::value<LPCoin<T0, T1>>(&v0.lp_coin_reserve) - 1000), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

