module 0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::exchange {
    struct CustodialPoolsIndex has key {
        id: 0x2::object::UID,
        managers: 0x2::vec_set::VecSet<address>,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_close_loop: bool,
    }

    struct CustodialPool has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct EXCHANGE has drop {
        dummy_field: bool,
    }

    struct CurveCreatedEvent has copy, drop {
        curve_id: 0x2::object::ID,
        quote_token_type: 0x1::ascii::String,
        quote_token_name: 0x1::ascii::String,
        quote_token_symbol: 0x1::ascii::String,
        curve_type: 0x1::ascii::String,
        curve_image: 0x1::option::Option<0x2::url::Url>,
        supply_amount: u64,
        virtual_a_amount: u64,
        presale_end_time: u64,
        time_created: u64,
    }

    struct SwapEvent has copy, drop {
        curve_id: 0x2::object::ID,
        base_token_type: 0x1::ascii::String,
        quote_token_type: 0x1::ascii::String,
        is_buy: bool,
        input_amount: u64,
        output_amount: u64,
        base_reserve_val: u64,
        quote_reserve_val: u64,
        user: address,
    }

    struct BidEvent has copy, drop {
        curve_id: 0x2::object::ID,
        quote_token_type: 0x1::ascii::String,
        input_amount: u64,
        user: address,
    }

    struct FeeEvent has copy, drop {
        amount: u64,
        user: address,
        coin_type: 0x1::ascii::String,
    }

    struct DisperseEvent has copy, drop, store {
        curve_id: 0x2::object::ID,
        quote_token_type: 0x1::ascii::String,
        input_amount: u64,
        output_amount: u64,
        user: address,
    }

    struct DisperseEvents has copy, drop {
        events: vector<DisperseEvent>,
    }

    struct AdminSettings has key {
        id: 0x2::object::UID,
        default_presale_duration: u64,
        swap_fee: u64,
        default_bid_percentage: u64,
        version_set: 0x2::vec_set::VecSet<u64>,
        min_trade_amount: u64,
    }

    struct FeeCollector has key {
        id: 0x2::object::UID,
    }

    struct PresaleCommit has drop, store {
        user: address,
        amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Curve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        a_balance: 0x2::balance::Balance<T0>,
        b_balance: 0x2::balance::Balance<T1>,
        virtual_a_amount: u64,
        swap_fee: u64,
        presale_bal: 0x2::balance::Balance<T0>,
        presale_commits: 0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::BigVector<PresaleCommit>,
        b_initial_value: u64,
        presale_total_commits: u64,
        presale_max_a: u64,
        presale_end_time: u64,
        presale_completed: bool,
    }

    public fun add_manager(arg0: &mut CustodialPoolsIndex, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: &AdminCap, arg3: u64) {
        0x2::vec_set::insert<u64>(&mut arg0.version_set, arg3);
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg3);
    }

    public fun admin_bid_with_custodial_account<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        assert_is_manager(arg1, arg6);
        assert!(arg3 >= arg0.min_trade_amount, 10);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_custodial_pool_mut(arg1, arg5).id, 0x1::type_name::get<T0>()), arg3), arg6);
        assert!(0x2::clock::timestamp_ms(arg4) < v0.presale_end_time, 1);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = v2 + v0.presale_total_commits;
        assert!(v3 < v0.presale_max_a, 2);
        assert!(!v0.presale_completed, 4);
        let v4 = BidEvent{
            curve_id         : arg2,
            quote_token_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            input_amount     : v2,
            user             : arg5,
        };
        0x2::event::emit<BidEvent>(v4);
        0x2::balance::join<T0>(&mut v0.presale_bal, 0x2::coin::into_balance<T0>(v1));
        v0.presale_total_commits = v3;
        let v5 = PresaleCommit{
            user   : arg5,
            amount : v2,
        };
        0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::push_back<PresaleCommit>(&mut v0.presale_commits, v5);
    }

    public fun admin_create_custodial_pool(arg0: &mut CustodialPoolsIndex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = managers(arg0);
        let v1 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_set::contains<address>(&v0, &v1)) {
            err_sender_is_not_authorized();
        };
        let v2 = CustodialPool{
            id    : 0x2::object::new(arg2),
            owner : arg1,
        };
        0x2::dynamic_object_field::add<address, CustodialPool>(&mut arg0.id, arg1, v2);
    }

    public fun admin_swap_a_to_b_with_custodial_account<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: u64, arg5: address, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        assert_is_manager(arg1, arg7);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        let v1 = get_custodial_pool_mut(arg1, arg5);
        assert!(v0.presale_completed, 5);
        let v2 = 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), arg4), arg7));
        let v3 = &mut v2;
        take_fee<T0>(arg3, v0.swap_fee, v3, arg5);
        let (v4, v5) = get_reserves<T0, T1>(v0);
        let v6 = 0x2::balance::value<T0>(&v2);
        let v7 = get_output_amount(v6, v4 + v0.virtual_a_amount, v5);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(v7 >= 0x1::option::extract<u64>(&mut arg6), 11);
        };
        0x2::balance::join<T0>(&mut v0.a_balance, v2);
        let (v8, v9) = get_reserves<T0, T1>(v0);
        let v10 = SwapEvent{
            curve_id          : arg2,
            base_token_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_token_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            is_buy            : true,
            input_amount      : v6,
            output_amount     : v7,
            base_reserve_val  : v8,
            quote_reserve_val : v9,
            user              : arg5,
        };
        0x2::event::emit<SwapEvent>(v10);
        let v11 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.b_balance, v7), arg7);
        deposit_custodial_pool<T1>(arg1, arg5, v11, arg7);
    }

    public fun admin_swap_b_to_a_with_custodial_account<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: u64, arg5: address, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        assert_is_manager(arg1, arg7);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        assert!(v0.presale_completed, 5);
        let v1 = get_custodial_pool_mut(arg1, arg5);
        let v2 = 0x2::coin::into_balance<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.id, 0x1::type_name::get<T1>()), arg4), arg7));
        let v3 = &mut v2;
        take_fee<T1>(arg3, v0.swap_fee, v3, arg5);
        let (v4, v5) = get_reserves<T0, T1>(v0);
        let v6 = 0x2::balance::value<T1>(&v2);
        let v7 = get_output_amount(v6, v5, v4 + v0.virtual_a_amount);
        if (0x1::option::is_some<u64>(&arg6)) {
            assert!(v7 >= 0x1::option::extract<u64>(&mut arg6), 11);
        };
        0x2::balance::join<T1>(&mut v0.b_balance, v2);
        let (v8, v9) = get_reserves<T0, T1>(v0);
        let v10 = SwapEvent{
            curve_id          : arg2,
            base_token_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_token_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            is_buy            : false,
            input_amount      : v6,
            output_amount     : v7,
            base_reserve_val  : v8,
            quote_reserve_val : v9,
            user              : arg5,
        };
        0x2::event::emit<SwapEvent>(v10);
        let v11 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.a_balance, v7), arg7);
        deposit_custodial_pool<T0>(arg1, arg5, v11, arg7);
    }

    public fun admin_withdraw_custodial_pool<T0>(arg0: &mut CustodialPoolsIndex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_custodial_version(arg0);
        assert_custodial_pools_open_loop(arg0);
        let v0 = managers(arg0);
        let v1 = get_custodial_pool_mut(arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_set::contains<address>(&v0, &v2) && v2 != v1.owner) {
            err_sender_is_not_authorized();
        };
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, 0x2::balance::value<T0>(v3)), arg2)
    }

    fun assert_custodial_pools_open_loop(arg0: &CustodialPoolsIndex) {
        assert!(!arg0.is_close_loop, 8);
    }

    fun assert_is_manager(arg0: &mut CustodialPoolsIndex, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = managers(arg0);
        if (!0x2::vec_set::contains<address>(&v1, &v0)) {
            err_sender_is_not_authorized();
        };
    }

    fun assert_valid_custodial_version(arg0: &CustodialPoolsIndex) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 6);
    }

    fun assert_valid_version(arg0: &AdminSettings) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 6);
    }

    public fun bid<T0, T1>(arg0: &mut AdminSettings, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert!(0x2::coin::value<T0>(&arg3) >= arg0.min_trade_amount, 10);
        let v0 = get_curve_mut<T0, T1>(arg0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < v0.presale_end_time, 1);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = v1 + v0.presale_total_commits;
        assert!(v2 < v0.presale_max_a, 2);
        assert!(!v0.presale_completed, 4);
        let v3 = BidEvent{
            curve_id         : arg1,
            quote_token_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            input_amount     : v1,
            user             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BidEvent>(v3);
        0x2::balance::join<T0>(&mut v0.presale_bal, 0x2::coin::into_balance<T0>(arg3));
        v0.presale_total_commits = v2;
        let v4 = PresaleCommit{
            user   : 0x2::tx_context::sender(arg4),
            amount : v1,
        };
        0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::push_back<PresaleCommit>(&mut v0.presale_commits, v4);
    }

    public fun bid_with_custodial_account<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        assert!(arg3 >= arg0.min_trade_amount, 10);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut get_custodial_pool_mut(arg1, 0x2::tx_context::sender(arg5)).id, 0x1::type_name::get<T0>()), arg3), arg5);
        assert!(0x2::clock::timestamp_ms(arg4) < v0.presale_end_time, 1);
        let v2 = 0x2::coin::value<T0>(&v1);
        let v3 = v2 + v0.presale_total_commits;
        assert!(v3 < v0.presale_max_a, 2);
        assert!(!v0.presale_completed, 4);
        let v4 = BidEvent{
            curve_id         : arg2,
            quote_token_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            input_amount     : v2,
            user             : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<BidEvent>(v4);
        0x2::balance::join<T0>(&mut v0.presale_bal, 0x2::coin::into_balance<T0>(v1));
        v0.presale_total_commits = v3;
        let v5 = PresaleCommit{
            user   : 0x2::tx_context::sender(arg5),
            amount : v2,
        };
        0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::push_back<PresaleCommit>(&mut v0.presale_commits, v5);
    }

    public fun create_curve<T0, T1>(arg0: &mut AdminSettings, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg0);
        assert!(0x2::coin::total_supply<T1>(&arg1) == 0, 0);
        let v0 = if (0x1::option::is_some<u64>(&arg5)) {
            0x1::option::extract<u64>(&mut arg5)
        } else {
            arg0.default_bid_percentage
        };
        let v1 = if (0x1::option::is_some<u64>(&arg6)) {
            0x1::option::extract<u64>(&mut arg6)
        } else {
            arg0.default_presale_duration
        };
        let v2 = (0x1::u64::pow(10, 0x2::coin::get_decimals<T1>(arg2)) as u64) * arg3;
        let v3 = 0x2::clock::timestamp_ms(arg9) + v1;
        let v4 = 0x2::object::new(arg10);
        let v5 = 0x2::object::uid_to_inner(&v4);
        let v6 = Curve<T0, T1>{
            id                    : v4,
            a_balance             : 0x2::balance::zero<T0>(),
            b_balance             : 0x2::coin::mint_balance<T1>(&mut arg1, v2),
            virtual_a_amount      : arg4,
            swap_fee              : arg0.swap_fee,
            presale_bal           : 0x2::balance::zero<T0>(),
            presale_commits       : 0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::new<PresaleCommit>(slice_size(), arg10),
            b_initial_value       : v2,
            presale_total_commits : 0,
            presale_max_a         : (((v2 as u128) * (arg4 as u128) / ((v2 - safe_percentage(v2, v0)) as u128)) as u64),
            presale_end_time      : v3,
            presale_completed     : false,
        };
        let v7 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::coin::TreasuryCap<T1>>(&mut arg0.id, v7, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Curve<T0, T1>>(&mut arg0.id, v5, v6);
        let v8 = CurveCreatedEvent{
            curve_id           : v5,
            quote_token_type   : v7,
            quote_token_name   : arg8,
            quote_token_symbol : 0x2::coin::get_symbol<T1>(arg2),
            curve_type         : arg7,
            curve_image        : 0x2::coin::get_icon_url<T1>(arg2),
            supply_amount      : arg3,
            virtual_a_amount   : arg4,
            presale_end_time   : v3,
            time_created       : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<CurveCreatedEvent>(v8);
        v5
    }

    public fun create_custodial_pool(arg0: &mut CustodialPoolsIndex, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CustodialPool{
            id    : 0x2::object::new(arg1),
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::dynamic_object_field::add<address, CustodialPool>(&mut arg0.id, 0x2::tx_context::sender(arg1), v0);
    }

    public fun deposit_custodial_pool<T0>(arg0: &mut CustodialPoolsIndex, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = managers(arg0);
        let v1 = get_custodial_pool_mut(arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg3);
        if (!0x2::vec_set::contains<address>(&v0, &v2) && v2 != v1.owner) {
            err_sender_is_not_authorized();
        };
        let v3 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v1.id, v3)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v3, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v3), 0x2::coin::into_balance<T0>(arg2));
    }

    public fun disperse<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        assert!(0x2::clock::timestamp_ms(arg5) > v0.presale_end_time || v0.presale_max_a == 0x2::balance::value<T0>(&v0.presale_bal), 3);
        assert!(!v0.presale_completed, 4);
        let v1 = v0.presale_total_commits;
        let v2 = 0x2::balance::split<T0>(&mut v0.presale_bal, v1);
        let v3 = &mut v2;
        take_fee<T0>(arg3, v0.swap_fee, v3, 0x2::tx_context::sender(arg7));
        0x2::balance::join<T0>(&mut v0.a_balance, v2);
        let v4 = if (0x1::option::is_some<u64>(&arg4)) {
            *0x1::option::borrow<u64>(&arg4)
        } else {
            1000
        };
        let v5 = if (0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::length<PresaleCommit>(&v0.presale_commits) > v4) {
            0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::length<PresaleCommit>(&v0.presale_commits) - v4
        } else {
            0
        };
        let v6 = 0x1::vector::empty<DisperseEvent>();
        while (0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::length<PresaleCommit>(&v0.presale_commits) > v5) {
            let v7 = 0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::pop_back<PresaleCommit>(&mut v0.presale_commits);
            let v8 = (((v7.amount as u128) * (get_output_amount(v1, v0.virtual_a_amount, v0.b_initial_value) as u128) / (v0.presale_total_commits as u128)) as u64);
            if (v8 == 0) {
                continue
            };
            let v9 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.b_balance, v8), arg7);
            let v10 = DisperseEvent{
                curve_id         : arg2,
                quote_token_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
                input_amount     : v7.amount,
                output_amount    : v8,
                user             : v7.user,
            };
            0x1::vector::push_back<DisperseEvent>(&mut v6, v10);
            if (arg6) {
                deposit_custodial_pool<T1>(arg1, v7.user, v9, arg7);
                continue
            };
            assert_custodial_pools_open_loop(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, v7.user);
        };
        let v11 = DisperseEvents{events: v6};
        0x2::event::emit<DisperseEvents>(v11);
        if (0x5689b1d19e9eb3c4d6872ecb7634f761a3b149cde08c4a882a498bb04b2e0893::big_vector::length<PresaleCommit>(&v0.presale_commits) == 0) {
            v0.presale_completed = true;
        };
    }

    fun err_sender_is_not_authorized() {
        abort 7
    }

    public fun get_curve<T0, T1>(arg0: &AdminSettings, arg1: 0x2::object::ID) : &Curve<T0, T1> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Curve<T0, T1>>(&arg0.id, arg1)
    }

    fun get_curve_mut<T0, T1>(arg0: &mut AdminSettings, arg1: 0x2::object::ID) : &mut Curve<T0, T1> {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Curve<T0, T1>>(&mut arg0.id, arg1)
    }

    public fun get_custodial_pool_balance<T0>(arg0: &CustodialPoolsIndex, arg1: address) : u64 {
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&0x2::dynamic_object_field::borrow<address, CustodialPool>(&arg0.id, arg1).id, 0x1::type_name::get<T0>()))
    }

    fun get_custodial_pool_mut(arg0: &mut CustodialPoolsIndex, arg1: address) : &mut CustodialPool {
        0x2::dynamic_object_field::borrow_mut<address, CustodialPool>(&mut arg0.id, arg1)
    }

    fun get_output_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = v0 * (arg2 as u128);
        let v2 = (arg1 as u128) + v0;
        assert!(v1 / v2 > 0, 9);
        ((v1 / v2) as u64)
    }

    fun get_reserves<T0, T1>(arg0: &Curve<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.a_balance), 0x2::balance::value<T1>(&arg0.b_balance))
    }

    fun init(arg0: EXCHANGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<EXCHANGE>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminSettings{
            id                       : 0x2::object::new(arg1),
            default_presale_duration : 86400000,
            swap_fee                 : 10000,
            default_bid_percentage   : 100000,
            version_set              : 0x2::vec_set::singleton<u64>(1),
            min_trade_amount         : 10000,
        };
        0x2::transfer::share_object<AdminSettings>(v1);
        let v2 = CustodialPoolsIndex{
            id            : 0x2::object::new(arg1),
            managers      : 0x2::vec_set::empty<address>(),
            version_set   : 0x2::vec_set::singleton<u64>(1),
            is_close_loop : true,
        };
        0x2::transfer::share_object<CustodialPoolsIndex>(v2);
        let v3 = FeeCollector{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<FeeCollector>(v3);
    }

    public fun managers(arg0: &mut CustodialPoolsIndex) : 0x2::vec_set::VecSet<address> {
        arg0.managers
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_manager(arg0: &mut CustodialPoolsIndex, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: &AdminCap, arg3: u64) {
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg3);
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg3);
    }

    fun safe_percentage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000) as u64)
    }

    public fun set_is_closed(arg0: &mut CustodialPoolsIndex, arg1: &AdminCap, arg2: bool) {
        arg0.is_close_loop = arg2;
    }

    public fun slice_size() : u64 {
        1000
    }

    public fun store_fee<T0>(arg0: &mut FeeCollector, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: 0x2::coin::Coin<T0>, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        assert_custodial_pools_open_loop(arg1);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        assert!(v0.presale_completed, 5);
        let v1 = 0x2::coin::into_balance<T0>(arg4);
        let v2 = &mut v1;
        take_fee<T0>(arg3, v0.swap_fee, v2, 0x2::tx_context::sender(arg6));
        let (v3, v4) = get_reserves<T0, T1>(v0);
        let v5 = 0x2::balance::value<T0>(&v1);
        let v6 = get_output_amount(v5, v3 + v0.virtual_a_amount, v4);
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(v6 >= 0x1::option::extract<u64>(&mut arg5), 11);
        };
        0x2::balance::join<T0>(&mut v0.a_balance, v1);
        let (v7, v8) = get_reserves<T0, T1>(v0);
        let v9 = SwapEvent{
            curve_id          : arg2,
            base_token_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_token_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            is_buy            : true,
            input_amount      : v5,
            output_amount     : v6,
            base_reserve_val  : v7,
            quote_reserve_val : v8,
            user              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SwapEvent>(v9);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.b_balance, v6), arg6)
    }

    public fun swap_a_to_b_with_custodial_account<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        let v1 = get_custodial_pool_mut(arg1, 0x2::tx_context::sender(arg6));
        assert!(v0.presale_completed, 5);
        let v2 = 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>()), arg4), arg6));
        let v3 = &mut v2;
        take_fee<T0>(arg3, v0.swap_fee, v3, 0x2::tx_context::sender(arg6));
        let (v4, v5) = get_reserves<T0, T1>(v0);
        let v6 = 0x2::balance::value<T0>(&v2);
        let v7 = get_output_amount(v6, v4 + v0.virtual_a_amount, v5);
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(v7 >= 0x1::option::extract<u64>(&mut arg5), 11);
        };
        0x2::balance::join<T0>(&mut v0.a_balance, v2);
        let (v8, v9) = get_reserves<T0, T1>(v0);
        let v10 = SwapEvent{
            curve_id          : arg2,
            base_token_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_token_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            is_buy            : true,
            input_amount      : v6,
            output_amount     : v7,
            base_reserve_val  : v8,
            quote_reserve_val : v9,
            user              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SwapEvent>(v10);
        let v11 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v0.b_balance, v7), arg6);
        let v12 = 0x2::tx_context::sender(arg6);
        deposit_custodial_pool<T1>(arg1, v12, v11, arg6);
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: 0x2::coin::Coin<T1>, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        assert_custodial_pools_open_loop(arg1);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        assert!(v0.presale_completed, 5);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = &mut v1;
        take_fee<T1>(arg3, v0.swap_fee, v2, 0x2::tx_context::sender(arg6));
        let (v3, v4) = get_reserves<T0, T1>(v0);
        let v5 = 0x2::balance::value<T1>(&v1);
        let v6 = get_output_amount(v5, v4, v3 + v0.virtual_a_amount);
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(v6 >= 0x1::option::extract<u64>(&mut arg5), 11);
        };
        0x2::balance::join<T1>(&mut v0.b_balance, v1);
        let (v7, v8) = get_reserves<T0, T1>(v0);
        let v9 = SwapEvent{
            curve_id          : arg2,
            base_token_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_token_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            is_buy            : false,
            input_amount      : v5,
            output_amount     : v6,
            base_reserve_val  : v7,
            quote_reserve_val : v8,
            user              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SwapEvent>(v9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.a_balance, v6), arg6)
    }

    public fun swap_b_to_a_with_custodial_account<T0, T1>(arg0: &mut AdminSettings, arg1: &mut CustodialPoolsIndex, arg2: 0x2::object::ID, arg3: &mut FeeCollector, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        assert_valid_custodial_version(arg1);
        let v0 = get_curve_mut<T0, T1>(arg0, arg2);
        assert!(v0.presale_completed, 5);
        let v1 = get_custodial_pool_mut(arg1, 0x2::tx_context::sender(arg6));
        let v2 = 0x2::coin::into_balance<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v1.id, 0x1::type_name::get<T1>()), arg4), arg6));
        let v3 = &mut v2;
        take_fee<T1>(arg3, v0.swap_fee, v3, 0x2::tx_context::sender(arg6));
        let (v4, v5) = get_reserves<T0, T1>(v0);
        let v6 = 0x2::balance::value<T1>(&v2);
        let v7 = get_output_amount(v6, v5, v4 + v0.virtual_a_amount);
        if (0x1::option::is_some<u64>(&arg5)) {
            assert!(v7 >= 0x1::option::extract<u64>(&mut arg5), 11);
        };
        0x2::balance::join<T1>(&mut v0.b_balance, v2);
        let (v8, v9) = get_reserves<T0, T1>(v0);
        let v10 = SwapEvent{
            curve_id          : arg2,
            base_token_type   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote_token_type  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            is_buy            : false,
            input_amount      : v6,
            output_amount     : v7,
            base_reserve_val  : v8,
            quote_reserve_val : v9,
            user              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<SwapEvent>(v10);
        let v11 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.a_balance, v7), arg6);
        let v12 = 0x2::tx_context::sender(arg6);
        deposit_custodial_pool<T0>(arg1, v12, v11, arg6);
    }

    fun take_fee<T0>(arg0: &mut FeeCollector, arg1: u64, arg2: &mut 0x2::balance::Balance<T0>, arg3: address) {
        let v0 = (((arg1 as u128) * (0x2::balance::value<T0>(arg2) as u128) / 1000000) as u64);
        let v1 = FeeEvent{
            amount    : v0,
            user      : arg3,
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        0x2::event::emit<FeeEvent>(v1);
        store_fee<T0>(arg0, 0x2::balance::split<T0>(arg2, v0));
    }

    public fun withdraw_custodial_pool<T0>(arg0: &mut CustodialPoolsIndex, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_custodial_version(arg0);
        assert_custodial_pools_open_loop(arg0);
        let v0 = managers(arg0);
        let v1 = get_custodial_pool_mut(arg0, arg1);
        let v2 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_set::contains<address>(&v0, &v2) && v2 != v1.owner) {
            err_sender_is_not_authorized();
        };
        let v3 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v3, 0x2::balance::value<T0>(v3)), arg2)
    }

    public fun withdraw_fees<T0>(arg0: &mut FeeCollector, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)), arg2)
    }

    // decompiled from Move bytecode v6
}

