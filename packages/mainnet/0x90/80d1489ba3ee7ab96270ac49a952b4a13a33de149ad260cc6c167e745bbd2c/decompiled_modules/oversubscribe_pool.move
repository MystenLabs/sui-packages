module 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::oversubscribe_pool {
    struct OversubcribePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        sale_coin: 0x2::balance::Balance<T0>,
        raise_coin: 0x2::balance::Balance<T1>,
        price: u128,
        total_token_sale: u64,
        complete_raise_limit: u64,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        total_purchase_amount: u64,
        duration_manager: 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::DurationManager,
        purchase_manager: 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseManager,
        white_list: 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::WhiteList,
        liquidity_injection_ratio: u64,
        liquidity_used_raise_amount: u64,
        liquidity_used_sale_amount: u64,
        is_liquidity_injected: bool,
        is_cancelled: bool,
        is_withdrawn: bool,
    }

    struct DaoFinalizedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        timestamp: u64,
        cetus_pool_address: address,
        initialize_price: u128,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
        sale_coin_type: 0x1::type_name::TypeName,
        raise_coin_type: 0x1::type_name::TypeName,
        price: u128,
        total_token_sale: u64,
        complete_raise_limit: u64,
        min_purchase_amount: u64,
        max_purchase_amount: u64,
        start_time: u64,
        liquidity_injection_ratio: u64,
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

    struct AddBulkWhiteListedAddressesEvent has copy, drop {
        pool_id: 0x2::object::ID,
        addresses: vector<address>,
        protection_limit_list: vector<u64>,
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

    public fun add_bulk_white_listed_addresses<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: vector<address>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg5);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::add_bulk_white_listed_addresses(&mut arg2.white_list, arg3, arg4);
        let v0 = AddBulkWhiteListedAddressesEvent{
            pool_id               : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            addresses             : arg3,
            protection_limit_list : arg4,
        };
        0x2::event::emit<AddBulkWhiteListedAddressesEvent>(v0);
    }

    public fun add_white_listed_address<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg5);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::add_white_listed_address(&mut arg2.white_list, arg3, arg4);
        let v0 = AddWhiteListedAddressEvent{
            pool_id          : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            address          : arg3,
            protection_limit : arg4,
        };
        0x2::event::emit<AddWhiteListedAddressEvent>(v0);
    }

    public fun add_white_listed_addresses<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: vector<address>, arg4: u64, arg5: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg5);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::add_white_listed_addresses(&mut arg2.white_list, arg3, arg4);
        let v0 = AddWhiteListedAddressesEvent{
            pool_id          : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            addresses        : arg3,
            protection_limit : arg4,
        };
        0x2::event::emit<AddWhiteListedAddressesEvent>(v0);
    }

    public fun cancel<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        assert!(!0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::is_claim_period(&arg2.duration_manager, arg3) && arg2.is_liquidity_injected == false, 11);
        arg2.is_cancelled = true;
    }

    public(friend) fun create<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (OversubcribePool<T0, T1>, 0x2::object::ID) {
        let v0 = 90909;
        let v1 = 1;
        assert!(arg2 > 0, 0);
        assert!(v1 > 0, 7);
        assert!(arg3 <= (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg2 as u128), v1, 1000000000000000000) as u64), 2);
        assert!(arg4 <= arg5, 1);
        assert!(arg6 > 0x2::clock::timestamp_ms(arg10) / 1000, 3);
        assert!(arg7 >= 0, 4);
        let v2 = OversubcribePool<T0, T1>{
            id                          : 0x2::object::new(arg11),
            owner                       : arg1,
            sale_coin                   : 0x2::balance::zero<T0>(),
            raise_coin                  : 0x2::balance::zero<T1>(),
            price                       : v1,
            total_token_sale            : arg2,
            complete_raise_limit        : arg3,
            min_purchase_amount         : arg4,
            max_purchase_amount         : arg5,
            total_purchase_amount       : 0,
            duration_manager            : 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::new(arg6, arg7, arg10),
            purchase_manager            : 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::new(arg11),
            white_list                  : 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::new(arg9, arg11),
            liquidity_injection_ratio   : v0,
            liquidity_used_raise_amount : 0,
            liquidity_used_sale_amount  : 0,
            is_liquidity_injected       : false,
            is_cancelled                : false,
            is_withdrawn                : false,
        };
        let v3 = arg2 + get_resever_sale_amount_for_liquidity<T0, T1>(&v2);
        assert!(0x2::coin::value<T0>(&arg8) >= v3, 5);
        0x2::balance::join<T0>(&mut v2.sale_coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg8, v3, arg11)));
        let v4 = 0x2::object::id<OversubcribePool<T0, T1>>(&v2);
        send_coin<T0>(arg8, 0x2::tx_context::sender(arg11));
        let v5 = CreatePoolEvent{
            pool_id                   : v4,
            owner                     : arg1,
            sale_coin_type            : 0x1::type_name::get<T0>(),
            raise_coin_type           : 0x1::type_name::get<T1>(),
            price                     : v1,
            total_token_sale          : arg2,
            complete_raise_limit      : arg3,
            min_purchase_amount       : arg4,
            max_purchase_amount       : arg5,
            start_time                : arg6,
            liquidity_injection_ratio : v0,
        };
        0x2::event::emit<CreatePoolEvent>(v5);
        (v2, v4)
    }

    public fun create_certificate_and_purchase<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg0);
        let v0 = 0x2::object::id<OversubcribePool<T0, T1>>(arg1);
        let v1 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::white_listed_address_protection_limit(&arg1.white_list, 0x2::tx_context::sender(arg5));
        let (v2, v3) = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::create_purchase_certificate(&mut arg1.purchase_manager, v0, v1, 0x2::tx_context::sender(arg5), arg5);
        let v4 = v2;
        let v5 = CreatePurchaseCertificateEvent{
            pool_id                 : v0,
            purchase_certificate_id : v3,
            protection_raise_limit  : v1,
        };
        0x2::event::emit<CreatePurchaseCertificateEvent>(v5);
        let v6 = &mut v4;
        purchase<T0, T1>(arg0, arg1, v6, arg2, arg3, arg4, arg5);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::transfer_purchase_certificate_to(&arg1.purchase_manager, v4, 0x2::tx_context::sender(arg5));
    }

    public fun emergency_deposit_raise<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg0);
        0x2::balance::join<T1>(&mut arg1.raise_coin, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, arg3, arg4)));
        send_coin<T1>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun emergency_deposit_sale<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg0);
        0x2::balance::join<T0>(&mut arg1.sale_coin, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, arg3, arg4)));
        send_coin<T0>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun finalize_dao<T0, T1>(arg0: &mut OversubcribePool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 4);
        arg0.is_withdrawn = true;
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0;
        let v4 = false;
        while (v3 < 0x1::vector::length<u8>(v1)) {
            let v5 = *0x1::vector::borrow<u8>(v1, v3);
            let v6 = *0x1::vector::borrow<u8>(0x1::ascii::as_bytes(&v2), v3);
            if (v6 < v5) {
                break
            };
            if (v6 > v5) {
                v4 = true;
                break
            };
            v3 = v3 + 1;
        };
        let (v7, v8, v9) = if (v4) {
            let v10 = sqrt(340282366920938463463374607431768211456 * (arg0.liquidity_used_sale_amount as u256) / (arg0.liquidity_used_raise_amount as u256));
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg1, arg2, 60, v10, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.raise_coin, arg0.liquidity_used_raise_amount), arg6), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sale_coin, arg0.liquidity_used_sale_amount), arg6), arg4, arg3, true, arg5, arg6);
            let v14 = v11;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v14);
            0x2::balance::join<T0>(&mut arg0.sale_coin, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut arg0.raise_coin, 0x2::coin::into_balance<T1>(v12));
            (v10, 0x2::object::id_to_address(&v15), v14)
        } else {
            let v16 = sqrt(340282366920938463463374607431768211456 * (arg0.liquidity_used_sale_amount as u256) / (arg0.liquidity_used_raise_amount as u256));
            let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg1, arg2, 60, v16, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sale_coin, arg0.liquidity_used_sale_amount), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.raise_coin, arg0.liquidity_used_raise_amount), arg6), arg3, arg4, false, arg5, arg6);
            let v20 = v17;
            let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v20);
            0x2::balance::join<T0>(&mut arg0.sale_coin, 0x2::coin::into_balance<T0>(v18));
            0x2::balance::join<T1>(&mut arg0.raise_coin, 0x2::coin::into_balance<T1>(v19));
            (v16, 0x2::object::id_to_address(&v21), v20)
        };
        let v22 = DaoFinalizedEvent{
            pool_id            : 0x2::object::id<OversubcribePool<T0, T1>>(arg0),
            timestamp          : 0x2::clock::timestamp_ms(arg5),
            cetus_pool_address : v8,
            initialize_price   : v7,
        };
        if (0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::get_locked_duration(&arg0.duration_manager) > 0) {
            0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::lock::lock_nft_to<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v9, arg0.owner, 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::get_locked_duration(&arg0.duration_manager), arg5, arg6);
        } else {
            0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v9, arg0.owner);
        };
        0x2::event::emit<DaoFinalizedEvent>(v22);
    }

    fun get_max_raise_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((arg0.total_token_sale as u128), arg0.price, 1000000000000000000) as u64)
    }

    fun get_resever_sale_amount_for_liquidity<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_round(arg0.total_token_sale, arg0.liquidity_injection_ratio, 1000000)
    }

    fun get_sale_amount_for_liquidity<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        if (arg0.total_purchase_amount >= get_max_raise_amount<T0, T1>(arg0)) {
            get_resever_sale_amount_for_liquidity<T0, T1>(arg0)
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(get_resever_sale_amount_for_liquidity<T0, T1>(arg0), get_sold_amount<T0, T1>(arg0), arg0.total_token_sale)
        }
    }

    fun get_sold_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        if (arg0.total_purchase_amount >= get_max_raise_amount<T0, T1>(arg0)) {
            arg0.total_token_sale
        } else {
            (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round((arg0.total_purchase_amount as u128), 1000000000000000000, arg0.price) as u64)
        }
    }

    fun is_sale_failed<T0, T1>(arg0: &OversubcribePool<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        if (arg0.is_cancelled) {
            return true
        };
        if (0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::is_claim_period(&arg0.duration_manager, arg1) && arg0.total_purchase_amount < arg0.complete_raise_limit) {
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
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::protection_limit_used(&arg0.white_list)
    }

    public fun purchase<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &mut 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseCertificate, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg0);
        assert!(arg1.is_cancelled == false, 19);
        assert!(0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::is_purchase_period(&arg1.duration_manager, arg5), 10);
        assert!(0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::info_pool_id(arg2) == 0x2::object::id<OversubcribePool<T0, T1>>(arg1), 20);
        assert!(arg3 <= 0x2::coin::value<T1>(&arg4), 5);
        let v0 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::purchased_raise_amount(arg2);
        assert!(v0 + arg3 <= arg1.max_purchase_amount, 9);
        assert!(v0 + arg3 >= arg1.min_purchase_amount, 8);
        let v1 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::update_for_purchase(&mut arg1.purchase_manager, arg2, arg3, 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::remainer_protection_limit(&arg1.white_list), arg6);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::increase_protection_limit_used(&mut arg1.white_list, v1);
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

    public fun redeem<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &mut 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseCertificate, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg0);
        assert!(0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::info_pool_id(arg2) == 0x2::object::id<OversubcribePool<T0, T1>>(arg1), 20);
        assert!(!0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::is_redeemed(arg2), 12);
        let (v0, v1) = if (is_sale_failed<T0, T1>(arg1, arg3)) {
            redeem_for_sale_failed<T0, T1>(arg1, arg2, arg4)
        } else {
            assert!(0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::is_claim_period(&arg1.duration_manager, arg3), 11);
            redeem_for_sale_success<T0, T1>(arg1, arg2, arg4)
        };
        let v2 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::refunded_raise_amount(arg2);
        send_coin<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.sale_coin, v0), arg4), 0x2::tx_context::sender(arg4));
        send_coin<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.raise_coin, v2), arg4), 0x2::tx_context::sender(arg4));
        let v3 = RedeemEvent{
            pool_id               : 0x2::object::id<OversubcribePool<T0, T1>>(arg1),
            obtained_sale_amount  : v0,
            used_raise_amount     : v1,
            refunded_raise_amount : v2,
        };
        0x2::event::emit<RedeemEvent>(v3);
    }

    fun redeem_for_sale_failed<T0, T1>(arg0: &mut OversubcribePool<T0, T1>, arg1: &mut 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseCertificate, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::update_for_redeem(&mut arg0.purchase_manager, arg1, 0, 0, arg2);
        (0, 0)
    }

    fun redeem_for_sale_oversubcribe<T0, T1>(arg0: &OversubcribePool<T0, T1>, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseCertificate) : (u64, u64) {
        let v0 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::protection_raise_amount(arg1);
        let v1 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::purchased_raise_amount(arg1) - v0;
        let v2 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::protection_limit_used(&arg0.white_list);
        let v3 = get_max_raise_amount<T0, T1>(arg0) - v2;
        let v4 = arg0.total_purchase_amount - v2;
        (((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::full_mul(v0, v4) + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::full_mul(v1, v3), 1000000000000000000) / 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul((v4 as u128), arg0.price)) as u64), v0 + 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v1, v3, v4))
    }

    fun redeem_for_sale_success<T0, T1>(arg0: &mut OversubcribePool<T0, T1>, arg1: &mut 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseCertificate, arg2: &0x2::tx_context::TxContext) : (u64, u64) {
        let (v0, v1) = redeem_for_sale_unoversubcribe<T0, T1>(arg0, arg1);
        let (v2, v3) = if (arg0.total_purchase_amount <= get_max_raise_amount<T0, T1>(arg0)) {
            (v0, v1)
        } else {
            redeem_for_sale_oversubcribe<T0, T1>(arg0, arg1)
        };
        assert!(v3 <= v1, 24);
        assert!(v2 <= (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil((v3 as u128), 1000000000000000000, arg0.price) as u64), 24);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::update_for_redeem(&mut arg0.purchase_manager, arg1, v2, v3, arg2);
        (v2, v3)
    }

    fun redeem_for_sale_unoversubcribe<T0, T1>(arg0: &OversubcribePool<T0, T1>, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::PurchaseCertificate) : (u64, u64) {
        let v0 = 0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::purchase_manager::purchased_raise_amount(arg1);
        ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_floor((v0 as u128), 1000000000000000000, arg0.price) as u64), v0)
    }

    public fun remove_white_listed_address<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg4);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::remove_white_listed_address(&mut arg2.white_list, arg3);
        let v0 = RemoveWhiteListedAddressEvent{
            pool_id : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            address : arg3,
        };
        0x2::event::emit<RemoveWhiteListedAddressEvent>(v0);
    }

    public fun remove_white_listed_addresses<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: vector<address>, arg4: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg4);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::remove_white_listed_addresses(&mut arg2.white_list, arg3);
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

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public fun total_purchase_amount<T0, T1>(arg0: &OversubcribePool<T0, T1>) : u64 {
        arg0.total_purchase_amount
    }

    public fun update_pool_duration<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::update(arg0, &mut arg2.duration_manager, arg3, arg4, arg5);
    }

    public fun update_pool_owner<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg4);
        arg2.owner = arg3;
        let v0 = UpdatePoolOwnerEvent{
            pool_id : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            owner   : arg3,
        };
        0x2::event::emit<UpdatePoolOwnerEvent>(v0);
    }

    public fun update_protection_hard_cap<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        if (arg3 > get_max_raise_amount<T0, T1>(arg2)) {
            abort 23
        };
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg4);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::update_protection_hard_cap(&mut arg2.white_list, arg3);
        let v0 = UpdateWhiteListedProtectionHardCapEvent{
            pool_id             : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            protection_hard_cap : arg3,
        };
        0x2::event::emit<UpdateWhiteListedProtectionHardCapEvent>(v0);
    }

    public fun update_white_listed_address<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::AdminCap, arg1: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg2: &mut OversubcribePool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg1);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::assert_init_period(&arg2.duration_manager, arg5);
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::white_list::update_white_listed_address(&mut arg2.white_list, arg3, arg4);
        let v0 = UpdateWhiteListedAddressEvent{
            pool_id          : 0x2::object::id<OversubcribePool<T0, T1>>(arg2),
            address          : arg3,
            protection_limit : arg4,
        };
        0x2::event::emit<UpdateWhiteListedAddressEvent>(v0);
    }

    public fun withdraw<T0, T1>(arg0: &0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::PackageVersion, arg1: &mut OversubcribePool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::config::checked_package_version(arg0);
        assert!(!arg1.is_withdrawn, 22);
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 21);
        let (v0, v1, v2) = if (is_sale_failed<T0, T1>(arg1, arg2)) {
            (0, arg1.total_token_sale + get_resever_sale_amount_for_liquidity<T0, T1>(arg1), false)
        } else {
            assert!(0x9080d1489ba3ee7ab96270ac49a952b4a13a33de149ad260cc6c167e745bbd2c::duration::is_claim_period(&arg1.duration_manager, arg2), 11);
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
            (arg0.total_purchase_amount - arg0.liquidity_used_raise_amount, arg0.total_token_sale + get_resever_sale_amount_for_liquidity<T0, T1>(arg0) - arg0.liquidity_used_sale_amount - get_sold_amount<T0, T1>(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

