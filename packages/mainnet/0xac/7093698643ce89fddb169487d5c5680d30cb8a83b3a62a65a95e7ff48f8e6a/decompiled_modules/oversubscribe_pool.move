module 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::oversubscribe_pool {
    struct OversubcribePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        sale_coin: 0x2::balance::Balance<T0>,
        raise_coin: 0x2::balance::Balance<T1>,
        price: u128,
        total_supply: u64,
        complete_raise_limit: u64,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        total_purchase_amount: u64,
        duration_manager: 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::DurationManager,
        purchase_manager: 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseManager,
        white_list: 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::WhiteList,
        liquidity_injection_ratio: u64,
        liquidity_used_raise_amount: u64,
        liquidity_used_sale_amount: u64,
        is_liquidity_injected: bool,
        is_cancelled: bool,
        is_withdrawn: bool,
        current_sqrt_price_min: u128,
        current_sqrt_price_max: u128,
        tick_spacing: u32,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        sale_coin_type: 0x1::type_name::TypeName,
        raise_coin_type: 0x1::type_name::TypeName,
        price: u128,
        total_supply: u64,
        complete_raise_limit: u64,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        start_time: u64,
        purchase_duration: u64,
        lock_up_duration: u64,
        liquidity_injection_ratio: u64,
        current_sqrt_price_min: u128,
        current_sqrt_price_max: u128,
        tick_spacing: u32,
    }

    struct CreatePurchaseCertificateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        purchase_certificate_id: 0x2::object::ID,
        protection_raise_limit: u64,
    }

    struct AddWhiteListedAddressEvent has copy, drop {
        pool_id: 0x2::object::ID,
        address: address,
        protection_limit: u64,
    }

    struct AddWhiteListedAddressesEvent has copy, drop {
        pool_id: 0x2::object::ID,
        addresses: vector<address>,
        protection_limit: u64,
    }

    struct RemoveWhiteListedAddressEvent has copy, drop {
        pool_id: 0x2::object::ID,
        address: address,
    }

    struct RemoveWhiteListedAddressesEvent has copy, drop {
        pool_id: 0x2::object::ID,
        addresses: vector<address>,
    }

    struct UpdateWhiteListedAddressEvent has copy, drop {
        pool_id: 0x2::object::ID,
        address: address,
        protection_limit: u64,
    }

    struct UpdateWhiteListedProtectionHardCapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        protection_hard_cap: u64,
    }

    struct UpdatePoolOwnerEvent has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
    }

    struct UpdateClmmPoolInfo has copy, drop {
        pool_id: 0x2::object::ID,
        tick_spacing: u32,
        current_sqrt_price_min: u128,
        current_sqrt_price_max: u128,
    }

    struct PurchaseEvent has copy, drop {
        pool_id: 0x2::object::ID,
        raise_amount: u64,
        used_protection_raise_amount: u64,
    }

    struct RedeemEvent has copy, drop {
        pool_id: 0x2::object::ID,
        obtained_sale_amount: u64,
        used_raise_amount: u64,
        refunded_raise_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        obtained_raise_amount: u64,
        refunded_sale_amount: u64,
        is_raise_success: bool,
    }

    struct InjectLiquidityEvent has copy, drop {
        pool_id: 0x2::object::ID,
        clmm_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sqrt_price_at_injection: u128,
        tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        raise_amount_for_liquidity: u64,
        sale_amount_for_liquidity: u64,
        lock_duration: u64,
    }

    public fun add_white_listed_address<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg5);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::add_white_listed_address(&mut arg2.white_list, arg3, arg4);
        let v0 = AddWhiteListedAddressEvent{
            pool_id          : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            address          : arg3,
            protection_limit : arg4,
        };
        0x2::event::emit<AddWhiteListedAddressEvent>(v0);
    }

    public fun add_white_listed_addresses<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: vector<address>, arg4: u64, arg5: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg5);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::add_white_listed_addresses(&mut arg2.white_list, arg3, arg4);
        let v0 = AddWhiteListedAddressesEvent{
            pool_id          : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            addresses        : arg3,
            protection_limit : arg4,
        };
        0x2::event::emit<AddWhiteListedAddressesEvent>(v0);
    }

    public fun cancel<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        assert!(!0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_claim_period(&arg2.duration_manager, arg3) && arg2.is_liquidity_injected == false, 11);
        arg2.is_cancelled = true;
    }

    public(friend) fun create<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: address, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u32, arg14: 0x2::coin::Coin<T0>, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (OversubcribePool<T0, T1>, 0x2::object::ID) {
        assert!(arg3 > 0, 0);
        assert!(arg2 > 0, 7);
        let v0 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg3 as u128), arg2, 1000000000000000000) as u64);
        assert!(arg4 <= v0, 2);
        assert!(arg6 <= v0, 1);
        assert!(arg5 <= arg6, 1);
        assert!(arg7 > 0x2::clock::timestamp_ms(arg16) / 1000, 3);
        assert!(arg8 > 0, 4);
        assert!(arg12 >= arg11, 6);
        let v1 = OversubcribePool<T0, T1>{
            id                          : 0x2::object::new(arg17),
            owner                       : arg1,
            sale_coin                   : 0x2::balance::zero<T0>(),
            raise_coin                  : 0x2::balance::zero<T1>(),
            price                       : arg2,
            total_supply                : arg3,
            complete_raise_limit        : arg4,
            min_purchase_amount         : arg5,
            max_purchase_amount         : arg6,
            total_purchase_amount       : 0,
            duration_manager            : 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::new(arg7, arg8, arg9, arg16),
            purchase_manager            : 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::new(arg17),
            white_list                  : 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::new(arg15, arg17),
            liquidity_injection_ratio   : arg10,
            liquidity_used_raise_amount : 0,
            liquidity_used_sale_amount  : 0,
            is_liquidity_injected       : false,
            is_cancelled                : false,
            is_withdrawn                : false,
            current_sqrt_price_min      : arg11,
            current_sqrt_price_max      : arg12,
            tick_spacing                : arg13,
        };
        let v2 = arg3 + get_resever_sale_amount_for_liquidity<T0, T1>(&v1);
        assert!(0x2::coin::value<T0>(&arg14) >= v2, 5);
        0x2::balance::join<T0>(&mut v1.sale_coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg14, v2, arg17)));
        let v3 = 0x2::object::id<OversubcribePool<T0, T1>>(&v1);
        send_coin<T0>(arg14, 0x2::tx_context::sender(arg17));
        let v4 = CreatePoolEvent{
            pool_id                   : v3,
            owner                     : arg1,
            sale_coin_type            : 0x1::type_name::get<T0>(),
            raise_coin_type           : 0x1::type_name::get<T1>(),
            price                     : arg2,
            total_supply              : arg3,
            complete_raise_limit      : arg4,
            min_purchase_amount       : arg5,
            max_purchase_amount       : arg6,
            start_time                : arg7,
            purchase_duration         : arg8,
            lock_up_duration          : arg9,
            liquidity_injection_ratio : arg10,
            current_sqrt_price_min    : arg11,
            current_sqrt_price_max    : arg12,
            tick_spacing              : arg13,
        };
        0x2::event::emit<CreatePoolEvent>(v4);
        (v1, v3)
    }

    public fun create_certificate_and_purchase<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<OversubcribePool<T0, T1>>(arg1);
        let v1 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::white_listed_address_protection_limit(&arg1.white_list, 0x2::tx_context::sender(arg5));
        let (v2, v3) = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::create_purchase_certificate(&mut arg1.purchase_manager, v0, v1, 0x2::tx_context::sender(arg5), arg5);
        let v4 = v2;
        let v5 = CreatePurchaseCertificateEvent{
            pool_id                 : v0,
            purchase_certificate_id : v3,
            protection_raise_limit  : v1,
        };
        0x2::event::emit<CreatePurchaseCertificateEvent>(v5);
        let v6 = &mut v4;
        purchase<T0, T1>(arg0, arg1, v6, arg2, arg3, arg4, arg5);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::transfer_purchase_certificate_to(&arg1.purchase_manager, v4, 0x2::tx_context::sender(arg5));
    }

    public fun emergency_deposit_raise<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        0x2::balance::join<T1>(&mut arg1.raise_coin, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg3, arg4)));
        send_coin<T1>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun emergency_deposit_sale<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        0x2::balance::join<T0>(&mut arg1.sale_coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)));
        send_coin<T0>(arg2, 0x2::tx_context::sender(arg4));
    }

    fun get_max_raise_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0.total_supply as u128), arg0.price, 1000000000000000000) as u64)
    }

    fun get_resever_sale_amount_for_liquidity<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_round(arg0.total_supply, arg0.liquidity_injection_ratio, 1000000)
    }

    fun get_sale_amount_for_liquidity<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        if (arg0.total_purchase_amount >= get_max_raise_amount<T0, T1>(arg0)) {
            get_resever_sale_amount_for_liquidity<T0, T1>(arg0)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(get_resever_sale_amount_for_liquidity<T0, T1>(arg0), get_sold_amount<T0, T1>(arg0), arg0.total_supply)
        }
    }

    fun get_sold_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        if (arg0.total_purchase_amount >= get_max_raise_amount<T0, T1>(arg0)) {
            arg0.total_supply
        } else {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg0.total_purchase_amount as u128), 1000000000000000000, arg0.price) as u64)
        }
    }

    fun inject_liquidity_to_clmm_pool<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, u64, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::min_tick(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1))));
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mod(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::tick_math::max_tick(), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg1))));
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, T1>(arg0, arg1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v1), arg7);
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v2, arg3, arg2, arg6);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, T1>(&v3);
        let v6 = if (arg2) {
            assert!(v4 == arg3, 17);
            v5
        } else {
            assert!(v5 == arg3, 17);
            v4
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(arg4, v4), 0x2::balance::split<T1>(arg5, v5), v3);
        (v2, v6, v0, v1)
    }

    public fun inject_liquidity_with_forward_clmm_pool<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        assert!(!arg1.is_cancelled, 19);
        assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_claim_period(&arg1.duration_manager, arg4), 11);
        assert!(arg1.liquidity_injection_ratio != 0, 14);
        assert!(!arg1.is_liquidity_injected, 15);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        assert!(v0 >= arg1.current_sqrt_price_min && v0 <= arg1.current_sqrt_price_max, 16);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg3) == arg1.tick_spacing, 18);
        let v1 = get_sale_amount_for_liquidity<T0, T1>(arg1);
        let v2 = &mut arg1.sale_coin;
        let v3 = &mut arg1.raise_coin;
        let (v4, v5, v6, v7) = inject_liquidity_to_clmm_pool<T0, T1>(arg2, arg3, true, v1, v2, v3, arg4, arg5);
        let v8 = v4;
        arg1.is_liquidity_injected = true;
        arg1.liquidity_used_raise_amount = v5;
        arg1.liquidity_used_sale_amount = v1;
        let v9 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::get_locked_duration(&arg1.duration_manager);
        if (v9 > 0) {
            0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::lock::lock_nft_to<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v8, arg1.owner, 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::get_locked_duration(&arg1.duration_manager), arg4, arg5);
        } else {
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v8, arg1.owner);
        };
        let v10 = InjectLiquidityEvent{
            pool_id                    : 0x2::object::id<OversubcribePool<T0, T1>>(arg1),
            clmm_pool_id               : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3),
            position_id                : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v8),
            sqrt_price_at_injection    : v0,
            tick_lower                 : v6,
            tick_upper                 : v7,
            raise_amount_for_liquidity : v5,
            sale_amount_for_liquidity  : v1,
            lock_duration              : v9,
        };
        0x2::event::emit<InjectLiquidityEvent>(v10);
    }

    public fun inject_liquidity_with_reverse_clmm_pool<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        assert!(!arg1.is_cancelled, 19);
        assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_claim_period(&arg1.duration_manager, arg4), 11);
        assert!(arg1.liquidity_injection_ratio != 0, 14);
        assert!(!arg1.is_liquidity_injected, 15);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg3);
        assert!(v0 >= arg1.current_sqrt_price_min && v0 <= arg1.current_sqrt_price_max, 16);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T1, T0>(arg3) == arg1.tick_spacing, 18);
        let v1 = get_sale_amount_for_liquidity<T0, T1>(arg1);
        let v2 = &mut arg1.raise_coin;
        let v3 = &mut arg1.sale_coin;
        let (v4, v5, v6, v7) = inject_liquidity_to_clmm_pool<T1, T0>(arg2, arg3, false, v1, v2, v3, arg4, arg5);
        let v8 = v4;
        arg1.is_liquidity_injected = true;
        arg1.liquidity_used_raise_amount = v5;
        arg1.liquidity_used_sale_amount = v1;
        let v9 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::get_locked_duration(&arg1.duration_manager);
        if (v9 > 0) {
            0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::lock::lock_nft_to<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v8, arg1.owner, 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::get_locked_duration(&arg1.duration_manager), arg4, arg5);
        } else {
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v8, arg1.owner);
        };
        let v10 = InjectLiquidityEvent{
            pool_id                    : 0x2::object::id<OversubcribePool<T0, T1>>(arg1),
            clmm_pool_id               : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>>(arg3),
            position_id                : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v8),
            sqrt_price_at_injection    : v0,
            tick_lower                 : v6,
            tick_upper                 : v7,
            raise_amount_for_liquidity : v5,
            sale_amount_for_liquidity  : v1,
            lock_duration              : v9,
        };
        0x2::event::emit<InjectLiquidityEvent>(v10);
    }

    fun is_sale_failed<T0, T1>(arg0: &OversubcribePool<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.is_cancelled) {
            return true
        };
        if (0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_claim_period(&arg0.duration_manager, arg1) && arg0.total_purchase_amount < arg0.complete_raise_limit) {
            return true
        };
        false
    }

    public fun liquidity_used_raise_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        arg0.liquidity_used_raise_amount
    }

    public fun liquidity_used_sale_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        arg0.liquidity_used_sale_amount
    }

    public fun protection_limit_used<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::protection_limit_used(&arg0.white_list)
    }

    public fun purchase<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &mut 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseCertificate, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        assert!(arg1.is_cancelled == false, 19);
        assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_purchase_period(&arg1.duration_manager, arg5), 10);
        assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::info_pool_id(arg2) == 0x2::object::id<OversubcribePool<T0, T1>>(arg1), 20);
        assert!(arg3 <= 0x2::coin::value<T1>(&arg4), 5);
        let v0 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::purchased_raise_amount(arg2);
        assert!(v0 + arg3 <= arg1.max_purchase_amount, 9);
        assert!(v0 + arg3 >= arg1.min_purchase_amount, 8);
        let v1 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::update_for_purchase(&mut arg1.purchase_manager, arg2, arg3, 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::remainer_protection_limit(&arg1.white_list), arg6);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::increase_protection_limit_used(&mut arg1.white_list, v1);
        arg1.total_purchase_amount = arg1.total_purchase_amount + arg3;
        0x2::balance::join<T1>(&mut arg1.raise_coin, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, arg3, arg6)));
        send_coin<T1>(arg4, 0x2::tx_context::sender(arg6));
        let v2 = PurchaseEvent{
            pool_id                      : 0x2::object::id<OversubcribePool<T0, T1>>(arg1),
            raise_amount                 : arg3,
            used_protection_raise_amount : v1,
        };
        0x2::event::emit<PurchaseEvent>(v2);
    }

    public fun raise_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.raise_coin)
    }

    public fun redeem<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &mut 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseCertificate, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::info_pool_id(arg2) == 0x2::object::id<OversubcribePool<T0, T1>>(arg1), 20);
        assert!(!0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::is_redeemed(arg2), 12);
        let (v0, v1) = if (is_sale_failed<T0, T1>(arg1, arg3)) {
            let (v2, v3) = redeem_for_sale_failed<T0, T1>(arg1, arg2, arg4);
            (v3, v2)
        } else {
            assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_claim_period(&arg1.duration_manager, arg3), 11);
            let (v4, v5) = redeem_for_sale_success<T0, T1>(arg1, arg2, arg4);
            (v5, v4)
        };
        let v6 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::refunded_raise_amount(arg2);
        send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sale_coin, v1), arg4), 0x2::tx_context::sender(arg4));
        send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.raise_coin, v6), arg4), 0x2::tx_context::sender(arg4));
        let v7 = RedeemEvent{
            pool_id               : 0x2::object::id<OversubcribePool<T0, T1>>(arg1),
            obtained_sale_amount  : v1,
            used_raise_amount     : v0,
            refunded_raise_amount : v6,
        };
        0x2::event::emit<RedeemEvent>(v7);
    }

    fun redeem_for_sale_failed<T0, T1>(arg0: &mut OversubcribePool<T0, T1>, arg1: &mut 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseCertificate, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::update_for_redeem(&mut arg0.purchase_manager, arg1, 0, 0, arg2);
        (0, 0)
    }

    fun redeem_for_sale_oversubcribe<T0, T1>(arg0: &OversubcribePool<T0, T1>, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseCertificate) : (u64, u64) {
        let v0 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::protection_raise_amount(arg1);
        let v1 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::purchased_raise_amount(arg1) - v0;
        let v2 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::protection_limit_used(&arg0.white_list);
        let v3 = get_max_raise_amount<T0, T1>(arg0) - v2;
        let v4 = arg0.total_purchase_amount - v2;
        (((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::full_mul(v0, v4) + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::full_mul(v1, v3), 1000000000000000000) / 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul((v4 as u128), arg0.price)) as u64), v0 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v1, v3, v4))
    }

    fun redeem_for_sale_success<T0, T1>(arg0: &mut OversubcribePool<T0, T1>, arg1: &mut 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseCertificate, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = redeem_for_sale_unoversubcribe<T0, T1>(arg0, arg1);
        let (v2, v3) = if (arg0.total_purchase_amount <= get_max_raise_amount<T0, T1>(arg0)) {
            (v0, v1)
        } else {
            redeem_for_sale_oversubcribe<T0, T1>(arg0, arg1)
        };
        assert!(v3 <= v1, 24);
        assert!(v2 <= (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((v3 as u128), 1000000000000000000, arg0.price) as u64), 24);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::update_for_redeem(&mut arg0.purchase_manager, arg1, v2, v3, arg2);
        (v2, v3)
    }

    fun redeem_for_sale_unoversubcribe<T0, T1>(arg0: &OversubcribePool<T0, T1>, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::PurchaseCertificate) : (u64, u64) {
        let v0 = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::purchase_manager::purchased_raise_amount(arg1);
        ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v0 as u128), 1000000000000000000, arg0.price) as u64), v0)
    }

    public fun remove_white_listed_address<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg4);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::remove_white_listed_address(&mut arg2.white_list, arg3);
        let v0 = RemoveWhiteListedAddressEvent{
            pool_id : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            address : arg3,
        };
        0x2::event::emit<RemoveWhiteListedAddressEvent>(v0);
    }

    public fun remove_white_listed_addresses<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: vector<address>, arg4: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg4);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::remove_white_listed_addresses(&mut arg2.white_list, arg3);
        let v0 = RemoveWhiteListedAddressesEvent{
            pool_id   : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            addresses : arg3,
        };
        0x2::event::emit<RemoveWhiteListedAddressesEvent>(v0);
    }

    public fun sale_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.sale_coin)
    }

    fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    public fun total_purchase_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        arg0.total_purchase_amount
    }

    public fun update_clmm_pool_info<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: u32, arg4: u128, arg5: u128) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        arg2.tick_spacing = arg3;
        arg2.current_sqrt_price_min = arg4;
        arg2.current_sqrt_price_max = arg5;
        let v0 = UpdateClmmPoolInfo{
            pool_id                : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            tick_spacing           : arg3,
            current_sqrt_price_min : arg4,
            current_sqrt_price_max : arg5,
        };
        0x2::event::emit<UpdateClmmPoolInfo>(v0);
    }

    public fun update_pool_duration<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::update(arg0, &mut arg2.duration_manager, arg3, arg4, arg5, arg6);
    }

    public fun update_pool_owner<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg4);
        arg2.owner = arg3;
        let v0 = UpdatePoolOwnerEvent{
            pool_id : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            owner   : arg3,
        };
        0x2::event::emit<UpdatePoolOwnerEvent>(v0);
    }

    public fun update_protection_hard_cap<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        if (arg3 > get_max_raise_amount<T0, T1>(arg2)) {
            abort 23
        };
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg4);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::update_protection_hard_cap(&mut arg2.white_list, arg3);
        let v0 = UpdateWhiteListedProtectionHardCapEvent{
            pool_id             : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            protection_hard_cap : arg3,
        };
        0x2::event::emit<UpdateWhiteListedProtectionHardCapEvent>(v0);
    }

    public fun update_white_listed_address<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::assert_init_period(&arg2.duration_manager, arg5);
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::white_list::update_white_listed_address(&mut arg2.white_list, arg3, arg4);
        let v0 = UpdateWhiteListedAddressEvent{
            pool_id          : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            address          : arg3,
            protection_limit : arg4,
        };
        0x2::event::emit<UpdateWhiteListedAddressEvent>(v0);
    }

    public fun withdraw<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg0);
        assert!(!arg1.is_withdrawn, 22);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 21);
        let (v0, v1, v2) = if (is_sale_failed<T0, T1>(arg1, arg2)) {
            (0, arg1.total_supply + get_resever_sale_amount_for_liquidity<T0, T1>(arg1), false)
        } else {
            assert!(0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::duration::is_claim_period(&arg1.duration_manager, arg2), 11);
            assert!(arg1.is_liquidity_injected || arg1.liquidity_injection_ratio == 0, 13);
            let (v3, v4) = withdraw_for_sale_success<T0, T1>(arg1);
            (v3, v4, true)
        };
        arg1.is_withdrawn = true;
        send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.raise_coin, v0), arg3), 0x2::tx_context::sender(arg3));
        send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sale_coin, v1), arg3), 0x2::tx_context::sender(arg3));
        let v5 = WithdrawEvent{
            pool_id               : 0x2::object::id<OversubcribePool<T0, T1>>(arg1),
            obtained_raise_amount : v0,
            refunded_sale_amount  : v1,
            is_raise_success      : v2,
        };
        0x2::event::emit<WithdrawEvent>(v5);
    }

    fun withdraw_for_sale_success<T0, T1>(arg0: &OversubcribePool<T0, T1>) : (u64, u64) {
        let v0 = get_max_raise_amount<T0, T1>(arg0);
        if (arg0.total_purchase_amount >= v0) {
            (v0 - arg0.liquidity_used_raise_amount, 0)
        } else {
            (arg0.total_purchase_amount - arg0.liquidity_used_raise_amount, arg0.total_supply + get_resever_sale_amount_for_liquidity<T0, T1>(arg0) - arg0.liquidity_used_sale_amount - get_sold_amount<T0, T1>(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

