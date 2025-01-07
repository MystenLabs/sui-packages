module 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct PurchaseMark has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        purchase_total: u64,
        obtain_sale_amount: u64,
        used_raise_amount: u64,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        is_settle: bool,
        is_cancel: bool,
        initialize_price: u128,
        reverse_price: u128,
        sale_coin: 0x2::balance::Balance<T0>,
        raise_coin: 0x2::balance::Balance<T1>,
        sale_total: u64,
        min_purchase: u64,
        max_purchase: u64,
        least_raise_amount: u64,
        softcap: u64,
        hardcap: u64,
        liquidity_rate: u64,
        duration_manager: 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::DurationManager,
        white_list: 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::WhiteList,
        unused_sale: u64,
        harvest_raise: u64,
        recipient: address,
        purchase_list: 0x2::table::Table<address, u64>,
        tick_spacing: u32,
        reality_raise_total: u64,
    }

    struct PurchaseEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        pool_id: 0x2::object::ID,
        claim_amount: u64,
        sale_amount: u64,
        raise_amount: u64,
    }

    struct WithdrawEvent has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        withdraw_type: 0x1::type_name::TypeName,
    }

    struct SettleEvent has copy, drop {
        pool_id: 0x2::object::ID,
        settle_price: u128,
        unused_sale: u64,
        unused_raise: u64,
        harvest_raise: u64,
        white_purchase_total: u64,
    }

    struct AddUsersEvent has copy, drop {
        pool_id: 0x2::object::ID,
        users: vector<address>,
        safe_purchase_limit: u64,
    }

    struct AddUserEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        safe_purchase_limit: u64,
    }

    struct RemoveUserEvent has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
    }

    struct UpdateDurationEvent has copy, drop {
        pool_id: 0x2::object::ID,
        new_start_time: u64,
        activity_duration: u64,
        settle_duration: u64,
        lock_duration: u64,
    }

    public(friend) fun claim<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut PurchaseMark, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg2.pool_id, 113);
        assert!(arg2.obtain_sale_amount == 0 && arg2.used_raise_amount == arg2.purchase_total, 110);
        let (v0, v1) = claim_internal<T0, T1>(arg0, arg2.purchase_total, arg3, arg4);
        0x2::pay::keep<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sale_coin, v0), arg4), arg4);
        0x2::pay::keep<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.raise_coin, v1), arg4), arg4);
        arg2.obtain_sale_amount = v0;
        arg2.used_raise_amount = arg2.purchase_total - v1;
        let v2 = ClaimEvent{
            pool_id      : 0x2::object::id<Pool<T0, T1>>(arg0),
            claim_amount : arg2.purchase_total,
            sale_amount  : v0,
            raise_amount : v1,
        };
        0x2::event::emit<ClaimEvent>(v2);
    }

    public(friend) fun update_pool_duration<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::update_pool_duration(arg0, &mut arg2.duration_manager, arg3, arg4, arg5, arg6, arg7);
        let v0 = UpdateDurationEvent{
            pool_id           : 0x2::object::id<Pool<T0, T1>>(arg2),
            new_start_time    : arg3,
            activity_duration : arg4,
            settle_duration   : arg5,
            lock_duration     : arg6,
        };
        0x2::event::emit<UpdateDurationEvent>(v0);
    }

    fun add_liquidity_and_lock_position<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u128, arg4: vector<0x2::coin::Coin<T0>>, arg5: vector<0x2::coin::Coin<T1>>, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: bool, arg9: bool, arg10: address, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::to_fixed_clmm_price<T0, T1>(arg1, arg0, arg4, arg5, arg3, arg8, arg12, arg13);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::lock::lock_nft_to<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::inject_liquidity_fix_token<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg9, arg12, arg13), arg10, arg11, arg12, arg13);
    }

    public(friend) fun add_user_to_whitelist<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg5) == 0, 101);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::add_user_to_whitelist(&mut arg2.white_list, arg3, arg4);
        let v0 = AddUserEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg2),
            user                : arg3,
            safe_purchase_limit : arg4,
        };
        0x2::event::emit<AddUserEvent>(v0);
    }

    public(friend) fun add_users_to_whitelist<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: vector<address>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg5) == 0, 101);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::add_users_to_whitelist(&mut arg2.white_list, arg3, arg4);
        let v0 = AddUsersEvent{
            pool_id             : 0x2::object::id<Pool<T0, T1>>(arg2),
            users               : arg3,
            safe_purchase_limit : arg4,
        };
        0x2::event::emit<AddUsersEvent>(v0);
    }

    fun assert_recipient_cap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.recipient == 0x2::tx_context::sender(arg1), 105);
    }

    fun calculate_claim_sale_and_raise_amount<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg1 == arg2 || arg0.reality_raise_total <= arg0.hardcap) {
            (0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((arg1 as u128), 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::CONST_DENOMINATOR(), arg0.initialize_price), 0)
        } else {
            let v2 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::get_purchase_total(&arg0.white_list);
            let v3 = arg0.reality_raise_total - v2;
            let v4 = arg1 - arg2;
            (0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((arg2 as u128), 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::CONST_DENOMINATOR(), arg0.initialize_price) + 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64(((arg0.sale_total - 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((v2 as u128), 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::CONST_DENOMINATOR(), arg0.initialize_price)) as u128), (v4 as u128), (v3 as u128)), 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64(((arg0.reality_raise_total - arg0.hardcap) as u128), (v4 as u128), (v3 as u128)))
        }
    }

    public(friend) fun cancel<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg3) < 3, 101);
        arg2.is_cancel = true;
    }

    fun claim_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = pool_status<T0, T1>(arg0, arg2);
        assert!(v0 == 3 || v0 == 4, 101);
        let (v1, v2) = get_claim_amount<T0, T1>(arg0, v0, arg1, arg3);
        assert!(0x2::balance::value<T1>(&arg0.raise_coin) - arg0.harvest_raise >= v2, 111);
        (v1, v2)
    }

    public(friend) fun create_mark_and_purchase<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg0, arg3) == 1, 101);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, u64>(&arg0.purchase_list, v0), 109);
        let v1 = PurchaseMark{
            id                 : 0x2::object::new(arg4),
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            purchase_total     : 0,
            obtain_sale_amount : 0,
            used_raise_amount  : 0,
        };
        let v2 = &mut v1;
        purchase_internal<T0, T1>(arg0, v2, arg2, v0);
        0x2::transfer::transfer<PurchaseMark>(v1, v0);
    }

    fun get_claim_amount<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg1 == 4) {
            (0, arg2)
        } else {
            let v2 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::get_whitelist_user_safe_purchased(&arg0.white_list, 0x2::tx_context::sender(arg3));
            calculate_claim_sale_and_raise_amount<T0, T1>(arg0, arg2, v2)
        }
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun initialize<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg1: address, arg2: u128, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u32, arg16: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg0);
        if (arg10 > 0) {
            assert!(arg15 >= 2, 114);
        };
        Pool<T0, T1>{
            id                  : 0x2::object::new(arg16),
            is_settle           : false,
            is_cancel           : false,
            initialize_price    : arg2,
            reverse_price       : 0,
            sale_coin           : arg3,
            raise_coin          : 0x2::balance::zero<T1>(),
            sale_total          : arg4,
            min_purchase        : arg5,
            max_purchase        : arg6,
            least_raise_amount  : arg7,
            softcap             : arg8,
            hardcap             : arg9,
            liquidity_rate      : arg10,
            duration_manager    : 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::new(arg11, arg12, arg13, arg14),
            white_list          : 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::new(arg16),
            unused_sale         : 0,
            harvest_raise       : 0,
            recipient           : arg1,
            purchase_list       : 0x2::table::new<address, u64>(arg16),
            tick_spacing        : arg15,
            reality_raise_total : 0,
        }
    }

    fun pool_status<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : u8 {
        if (arg0.is_settle) {
            3
        } else if (arg0.is_cancel) {
            4
        } else {
            let v1 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::current_time(arg1);
            if (0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::is_init_period(&arg0.duration_manager, v1)) {
                0
            } else if (0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::is_purchase_period(&arg0.duration_manager, v1)) {
                1
            } else if (0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::is_settle_period(&arg0.duration_manager, v1)) {
                if (0x2::balance::value<T1>(&arg0.raise_coin) < arg0.least_raise_amount) {
                    4
                } else {
                    2
                }
            } else {
                4
            }
        }
    }

    public(friend) fun purchase<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut PurchaseMark, arg3: 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg2.pool_id, 113);
        assert!(pool_status<T0, T1>(arg0, arg4) == 1, 101);
        purchase_internal<T0, T1>(arg0, arg2, arg3, 0x2::tx_context::sender(arg5));
    }

    fun purchase_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut PurchaseMark, arg2: 0x2::balance::Balance<T1>, arg3: address) {
        let v0 = 0x2::balance::value<T1>(&arg2);
        if (!0x2::table::contains<address, u64>(&arg0.purchase_list, arg3)) {
            0x2::table::add<address, u64>(&mut arg0.purchase_list, arg3, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.purchase_list, arg3);
        *v1 = *v1 + v0;
        assert!(*v1 <= arg0.max_purchase && *v1 >= arg0.min_purchase, 103);
        0x2::balance::join<T1>(&mut arg0.raise_coin, arg2);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::increse_white_list_purchase_total(&mut arg0.white_list, v0, arg3);
        arg0.reality_raise_total = arg0.reality_raise_total + v0;
        arg1.purchase_total = arg1.purchase_total + v0;
        arg1.used_raise_amount = arg1.purchase_total;
        let v2 = PurchaseEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount  : v0,
        };
        0x2::event::emit<PurchaseEvent>(v2);
    }

    public(friend) fun remove_user_from_whitelist<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg4) == 0, 101);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::remove_user_from_whitelist(&mut arg2.white_list, arg3);
        let v0 = RemoveUserEvent{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg2),
            user    : arg3,
        };
        0x2::event::emit<RemoveUserEvent>(v0);
    }

    fun send_settle_event<T0, T1>(arg0: &mut Pool<T0, T1>) {
        let v0 = if (arg0.reality_raise_total > arg0.hardcap) {
            arg0.reality_raise_total - arg0.hardcap
        } else {
            0
        };
        let v1 = SettleEvent{
            pool_id              : 0x2::object::id<Pool<T0, T1>>(arg0),
            settle_price         : arg0.initialize_price,
            unused_sale          : arg0.unused_sale,
            unused_raise         : v0,
            harvest_raise        : arg0.harvest_raise,
            white_purchase_total : 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::get_purchase_total(&arg0.white_list),
        };
        0x2::event::emit<SettleEvent>(v1);
    }

    public(friend) fun settle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(arg0.liquidity_rate == 0, 101);
        assert!(pool_status<T0, T1>(arg0, arg2) == 2, 101);
        let (_, _) = settle_internal<T0, T1>(arg0, 0, false, 0);
        send_settle_event<T0, T1>(arg0);
    }

    fun settle_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u128, arg2: bool, arg3: u32) : (u64, u64) {
        arg0.is_settle = true;
        let v0 = 0x2::balance::value<T0>(&arg0.sale_coin);
        let v1 = 0x2::balance::value<T1>(&arg0.raise_coin);
        let v2 = if (v1 <= arg0.hardcap) {
            v1
        } else {
            arg0.hardcap
        };
        if (arg2) {
            arg0.reverse_price = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div((arg0.sale_total as u128), 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::CONST_DENOMINATOR(), (arg0.hardcap as u128));
        };
        let v3 = if (v1 > arg0.hardcap) {
            arg0.sale_total
        } else {
            0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((v1 as u128), 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::CONST_DENOMINATOR(), arg0.initialize_price)
        };
        if (arg0.liquidity_rate > 0) {
            let v6 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::math_u128_mul_div_to_u64((v3 as u128), (arg0.liquidity_rate as u128), 10000);
            let v7 = 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::get_amount_to_liquidity(arg1, v6, arg3, !arg2);
            assert!(v0 - v3 >= v6, 106);
            arg0.unused_sale = v0 - v6 - v3;
            arg0.harvest_raise = v2 - v7;
            (v6, v7)
        } else {
            assert!(v0 >= v3, 106);
            arg0.unused_sale = v0 - v3;
            arg0.harvest_raise = v2;
            (0, 0)
        }
    }

    public(friend) fun settle_with_forward_clmm_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u128, arg5: vector<0x2::coin::Coin<T0>>, arg6: vector<0x2::coin::Coin<T1>>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg0, arg8) == 2, 101);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg3);
        assert!(arg0.tick_spacing == v0, 112);
        let (v1, v2) = settle_internal<T0, T1>(arg0, arg4, false, v0);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::verify_sqrt_price(arg0.initialize_price, arg4);
        add_liquidity_and_lock_position<T0, T1>(arg2, arg3, v0, arg4, arg5, arg6, 0x2::balance::split<T0>(&mut arg0.sale_coin, v1), 0x2::balance::split<T1>(&mut arg0.raise_coin, v2), arg7, true, arg0.recipient, 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::get_locked_duration(&arg0.duration_manager), arg8, arg9);
        send_settle_event<T0, T1>(arg0);
    }

    public(friend) fun settle_with_reverse_clmm_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg4: u128, arg5: vector<0x2::coin::Coin<T1>>, arg6: vector<0x2::coin::Coin<T0>>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg0, arg8) == 2, 101);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T1, T0>(arg3);
        assert!(arg0.tick_spacing == v0, 112);
        let (v1, v2) = settle_internal<T0, T1>(arg0, arg4, true, v0);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::utils::verify_sqrt_price(arg0.reverse_price, arg4);
        add_liquidity_and_lock_position<T1, T0>(arg2, arg3, v0, arg4, arg5, arg6, 0x2::balance::split<T1>(&mut arg0.raise_coin, v2), 0x2::balance::split<T0>(&mut arg0.sale_coin, v1), arg7, false, arg0.recipient, 0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::duration::get_locked_duration(&arg0.duration_manager), arg8, arg9);
        send_settle_event<T0, T1>(arg0);
    }

    public(friend) fun update_recipient_address<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: address, arg4: &0x2::clock::Clock) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg4) < 3, 101);
        assert!(arg3 != arg2.recipient, 104);
        arg2.recipient = arg3;
    }

    public(friend) fun update_whitelist_hard_cap_total<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg4) == 0, 101);
        assert!(arg3 < arg2.hardcap, 108);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::update_hard_cap_total(&mut arg2.white_list, arg3);
    }

    public(friend) fun update_whitelist_safe_limit_amount<T0, T1>(arg0: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::AdminCap, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &mut Pool<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert!(pool_status<T0, T1>(arg2, arg5) == 0, 101);
        assert!(arg4 <= arg2.max_purchase && arg4 >= arg2.min_purchase, 107);
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::whitelist::update_whitelist_user_safe_limit_amount(&mut arg2.white_list, arg3, arg4);
    }

    public(friend) fun withdraw_raise<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert_recipient_cap<T0, T1>(arg0, arg3);
        let v0 = withdraw_raise_internal<T0, T1>(arg0, arg2, arg3);
        arg0.harvest_raise = 0;
        let v1 = WithdrawEvent{
            pool_id       : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount        : 0x2::coin::value<T1>(&v0),
            withdraw_type : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::pay::keep<T1>(v0, arg3);
    }

    fun withdraw_raise_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(pool_status<T0, T1>(arg0, arg1) == 3, 101);
        assert!(0x2::balance::value<T1>(&arg0.raise_coin) >= arg0.harvest_raise && arg0.harvest_raise > 0, 102);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.raise_coin, arg0.harvest_raise), arg2)
    }

    public(friend) fun withdraw_sale<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::ConfigVersion, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x80d114c5d474eabc2eb2fcd1a0903f1eb5b5096a8dc4184d72453f7a9be728e4::config::checked_package_version(arg1);
        assert_recipient_cap<T0, T1>(arg0, arg3);
        let v0 = withdraw_sale_internal<T0, T1>(arg0, arg2, arg3);
        let v1 = WithdrawEvent{
            pool_id       : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount        : 0x2::coin::value<T0>(&v0),
            withdraw_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::pay::keep<T0>(v0, arg3);
    }

    fun withdraw_sale_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = pool_status<T0, T1>(arg0, arg1);
        assert!(v0 == 3 || v0 == 4, 101);
        let v1 = if (v0 == 3) {
            arg0.unused_sale
        } else {
            0x2::balance::value<T0>(&arg0.sale_coin)
        };
        assert!(v1 > 0, 102);
        arg0.unused_sale = 0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sale_coin, v1), arg2)
    }

    // decompiled from Move bytecode v6
}

