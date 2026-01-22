module 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_order {
    struct DCA_ORDER has drop {
        dummy_field: bool,
    }

    struct Order<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        user: address,
        in_deposited: u64,
        in_withdrawn: u64,
        out_withdrawn: u64,
        in_balance: 0x2::balance::Balance<T0>,
        out_balance: 0x2::balance::Balance<T1>,
        cycle_frequency: u64,
        in_amount_per_cycle: u64,
        amount_left_next_cycle: u64,
        next_cycle_at: u64,
        min_out_amount_per_cycle: u64,
        max_out_amount_per_cycle: u64,
        fee_rate: u64,
        status: u64,
        created_at: u64,
    }

    struct OrderIndexer has store, key {
        id: 0x2::object::UID,
        open_orders: 0x2::table::Table<0x2::object::ID, bool>,
        user_orders: 0x2::table::Table<address, 0x2::table::Table<0x2::object::ID, bool>>,
    }

    struct MakeDealReceipt {
        order_id: 0x2::object::ID,
        in_amount: u64,
        promise_out_amount: u64,
        fee_amount: u64,
    }

    struct InitEvent has copy, drop {
        indexer_id: 0x2::object::ID,
    }

    struct OpenOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        in_coin: 0x1::type_name::TypeName,
        out_coin: 0x1::type_name::TypeName,
        in_deposited: u64,
        cycle_count: u64,
        cycle_frequency: u64,
        in_amount_per_cycle: u64,
        in_amount_limit_per_cycle: u64,
        min_out_amount_per_cycle: u64,
        max_out_amount_per_cycle: u64,
        fee_rate: u64,
        created_at: u64,
    }

    struct MakeDealEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        in_coin: 0x1::type_name::TypeName,
        out_coin: 0x1::type_name::TypeName,
        in_amount: u64,
        out_amount: u64,
        promise_out_amount: u64,
        after_in_balance: u64,
        after_out_balance: u64,
        fee_amount: u64,
        execution_at: u64,
    }

    struct WithdrawEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        out_coin: 0x1::type_name::TypeName,
        out_withdrawn: u64,
        withdrawn_at: u64,
    }

    struct CancelOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        in_coin: 0x1::type_name::TypeName,
        out_coin: 0x1::type_name::TypeName,
        in_withdrawn: u64,
        out_withdrawn: u64,
        closed_at: u64,
    }

    struct CloseOrderEvent has copy, drop {
        order_id: 0x2::object::ID,
        user: address,
        out_coin: 0x1::type_name::TypeName,
        out_withdrawn: u64,
        closed_at: u64,
    }

    public fun cancel_order<T0, T1>(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: &mut Order<T0, T1>, arg2: &mut OrderIndexer, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::checked_package_version(arg0);
        assert!(arg1.user == 0x2::tx_context::sender(arg4), 9);
        assert!(arg1.status == 0, 13);
        let v0 = 0x2::object::uid_to_inner(&arg1.id);
        let v1 = 0x2::balance::value<T0>(&arg1.in_balance);
        let v2 = 0x2::balance::value<T1>(&arg1.out_balance);
        arg1.in_withdrawn = arg1.in_withdrawn + v1;
        arg1.out_withdrawn = arg1.out_withdrawn + v2;
        arg1.next_cycle_at = 0;
        arg1.amount_left_next_cycle = 0;
        arg1.status = 2;
        0x2::table::remove<0x2::object::ID, bool>(&mut arg2.open_orders, v0);
        *0x2::table::borrow_mut<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg2.user_orders, arg1.user), v0) = false;
        let v3 = CancelOrderEvent{
            order_id      : v0,
            user          : arg1.user,
            in_coin       : 0x1::type_name::get<T0>(),
            out_coin      : 0x1::type_name::get<T1>(),
            in_withdrawn  : v1,
            out_withdrawn : v2,
            closed_at     : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<CancelOrderEvent>(v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.in_balance, v1), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.out_balance, v2), arg4))
    }

    public fun flash_loan_for_make_deal<T0, T1>(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::DCAConfig, arg2: &mut 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::ProtocolFeeVault, arg3: &mut Order<T0, T1>, arg4: u64, arg5: vector<0x1::string::String>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MakeDealReceipt) {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::checked_package_version(arg0);
        assert!(arg3.status == 0, 13);
        assert!(validate_keepers<T0, T1>(arg0, arg1, arg3, arg4, arg5), 14);
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        assert!(arg3.amount_left_next_cycle > 0, 2);
        assert!(v0 >= arg3.next_cycle_at, 3);
        let v1 = 0x2::balance::split<T0>(&mut arg3.in_balance, arg3.amount_left_next_cycle);
        let v2 = if (arg3.fee_rate > 0) {
            let v3 = (((0x2::balance::value<T0>(&v1) as u128) * (arg3.fee_rate as u128) / 1000000) as u64);
            0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::receive_fee<T0>(arg2, 0x2::balance::split<T0>(&mut v1, v3));
            v3
        } else {
            0
        };
        let v4 = if (0x2::balance::value<T0>(&arg3.in_balance) >= arg3.in_amount_per_cycle * 2) {
            arg3.in_amount_per_cycle
        } else {
            0x2::balance::value<T0>(&arg3.in_balance)
        };
        arg3.amount_left_next_cycle = v4;
        if (arg3.amount_left_next_cycle > 0) {
            arg3.next_cycle_at = v0 + arg3.cycle_frequency;
        } else {
            arg3.next_cycle_at = 0;
        };
        let v5 = MakeDealReceipt{
            order_id           : 0x2::object::uid_to_inner(&arg3.id),
            in_amount          : arg3.amount_left_next_cycle,
            promise_out_amount : arg4,
            fee_amount         : v2,
        };
        (0x2::coin::from_balance<T0>(v1, arg7), v5)
    }

    fun init(arg0: DCA_ORDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OrderIndexer{
            id          : 0x2::object::new(arg1),
            open_orders : 0x2::table::new<0x2::object::ID, bool>(arg1),
            user_orders : 0x2::table::new<address, 0x2::table::Table<0x2::object::ID, bool>>(arg1),
        };
        0x2::transfer::share_object<OrderIndexer>(v0);
        let v1 = InitEvent{indexer_id: 0x2::object::id<OrderIndexer>(&v0)};
        0x2::event::emit<InitEvent>(v1);
    }

    public fun open_order<T0, T1>(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::DCAConfig, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: &0x2::clock::Clock, arg12: &mut OrderIndexer, arg13: &mut 0x2::tx_context::TxContext) {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2) / arg4;
        let v1 = 0x2::tx_context::sender(arg13);
        validate_order<T0, T1>(v1, arg0, arg1, v0, arg7, arg3, arg4, arg8, arg9, arg10, arg11);
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = 0x2::clock::timestamp_ms(arg11) / 1000;
        let v4 = 0x2::balance::value<T0>(&v2);
        let v5 = Order<T0, T1>{
            id                       : 0x2::object::new(arg13),
            user                     : v1,
            in_deposited             : v4,
            in_withdrawn             : 0,
            out_withdrawn            : 0,
            in_balance               : v2,
            out_balance              : 0x2::balance::zero<T1>(),
            cycle_frequency          : arg3,
            in_amount_per_cycle      : v4 / arg4,
            amount_left_next_cycle   : v0,
            next_cycle_at            : v3,
            min_out_amount_per_cycle : arg5,
            max_out_amount_per_cycle : arg6,
            fee_rate                 : arg8,
            status                   : 0,
            created_at               : v3,
        };
        let v6 = 0x2::object::id<Order<T0, T1>>(&v5);
        0x2::table::add<0x2::object::ID, bool>(&mut arg12.open_orders, v6, true);
        if (0x2::table::contains<address, 0x2::table::Table<0x2::object::ID, bool>>(&arg12.user_orders, v1)) {
            0x2::table::add<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg12.user_orders, v1), v6, true);
        } else {
            let v7 = 0x2::table::new<0x2::object::ID, bool>(arg13);
            0x2::table::add<0x2::object::ID, bool>(&mut v7, v6, true);
            0x2::table::add<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg12.user_orders, v1, v7);
        };
        0x2::transfer::share_object<Order<T0, T1>>(v5);
        let v8 = OpenOrderEvent{
            order_id                  : v6,
            user                      : v1,
            in_coin                   : 0x1::type_name::get<T0>(),
            out_coin                  : 0x1::type_name::get<T1>(),
            in_deposited              : v4,
            cycle_count               : arg4,
            cycle_frequency           : arg3,
            in_amount_per_cycle       : v4 / arg4,
            in_amount_limit_per_cycle : arg7,
            min_out_amount_per_cycle  : arg5,
            max_out_amount_per_cycle  : arg6,
            fee_rate                  : arg8,
            created_at                : v3,
        };
        0x2::event::emit<OpenOrderEvent>(v8);
    }

    fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>) {
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, 10);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&arg0);
        let v3 = 1;
        while (v3 < v2) {
            if (v3 <= v2 - 32 - 1) {
                0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&arg0, v3));
            } else {
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v3));
            };
            v3 = v3 + 1;
        };
        0x1::vector::remove<u8>(&mut v0, 0);
        (0x2::address::from_bytes(0x2::hash::blake2b256(&v0)), v0, v1)
    }

    public fun repay_for_make_deal<T0, T1>(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: &mut Order<T0, T1>, arg2: &mut OrderIndexer, arg3: 0x2::coin::Coin<T1>, arg4: MakeDealReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::checked_package_version(arg0);
        let MakeDealReceipt {
            order_id           : v0,
            in_amount          : v1,
            promise_out_amount : v2,
            fee_amount         : v3,
        } = arg4;
        assert!(v0 == 0x2::object::uid_to_inner(&arg1.id), 8);
        assert!(arg1.status == 0, 13);
        let v4 = 0x2::coin::value<T1>(&arg3);
        assert!(v4 >= v2, 6);
        assert!(v4 >= arg1.min_out_amount_per_cycle, 4);
        assert!(v4 <= arg1.max_out_amount_per_cycle, 5);
        let v5 = 0x2::clock::timestamp_ms(arg5) / 1000;
        0x2::balance::join<T1>(&mut arg1.out_balance, 0x2::coin::into_balance<T1>(arg3));
        let v6 = MakeDealEvent{
            order_id           : v0,
            user               : arg1.user,
            in_coin            : 0x1::type_name::get<T0>(),
            out_coin           : 0x1::type_name::get<T1>(),
            in_amount          : v1,
            out_amount         : v4,
            promise_out_amount : v2,
            after_in_balance   : 0x2::balance::value<T0>(&arg1.in_balance),
            after_out_balance  : 0x2::balance::value<T1>(&arg1.out_balance),
            fee_amount         : v3,
            execution_at       : v5,
        };
        0x2::event::emit<MakeDealEvent>(v6);
        if (arg1.amount_left_next_cycle == 0) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg2.open_orders, v0);
            let v7 = 0x2::balance::value<T1>(&arg1.out_balance);
            *0x2::table::borrow_mut<0x2::object::ID, bool>(0x2::table::borrow_mut<address, 0x2::table::Table<0x2::object::ID, bool>>(&mut arg2.user_orders, arg1.user), v0) = false;
            arg1.out_withdrawn = arg1.out_withdrawn + v7;
            arg1.status = 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.out_balance, v7), arg6), arg1.user);
            let v8 = CloseOrderEvent{
                order_id      : v0,
                user          : arg1.user,
                out_coin      : 0x1::type_name::get<T1>(),
                out_withdrawn : v7,
                closed_at     : v5,
            };
            0x2::event::emit<CloseOrderEvent>(v8);
        };
    }

    fun validate_keepers<T0, T1>(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::DCAConfig, arg2: &Order<T0, T1>, arg3: u64, arg4: vector<0x1::string::String>) : bool {
        if (0x1::vector::length<0x1::string::String>(&arg4) < 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::keeper_threshold(arg1)) {
            return false
        };
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0x2::object::id_bytes<Order<T0, T1>>(arg2);
        0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2.next_cycle_at));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2.amount_left_next_cycle));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            let (v3, v4) = verify_internal(arg0, v1, 0x1::vector::borrow<0x1::string::String>(&arg4, v2), 1);
            if (v3) {
                0x2::vec_set::insert<address>(&mut v0, v4);
            };
            v2 = v2 + 1;
        };
        0x2::vec_set::size<address>(&v0) >= 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::keeper_threshold(arg1)
    }

    fun validate_order<T0, T1>(arg0: address, arg1: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg2: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::DCAConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: &0x2::clock::Clock) {
        assert!(0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::is_coin_allow<T0, T1>(arg2), 15);
        assert!(arg3 >= 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::min_cycle_count(arg2), 0);
        assert!(arg4 > arg6, 7);
        assert!(arg5 >= 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::min_cycle_frequency(arg2), 1);
        let v0 = 0x2::clock::timestamp_ms(arg10) / 1000;
        let v1 = if (v0 > arg8) {
            v0 - arg8
        } else {
            arg8 - v0
        };
        assert!(v1 <= 0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::oracle_valid_duration(arg2), 11);
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg8));
        let (v3, _) = verify_internal(arg1, v2, &arg9, 0);
        assert!(v3, 12);
    }

    fun verify_internal(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: vector<u8>, arg2: &0x1::string::String, arg3: u8) : (bool, address) {
        let (v0, v1, v2) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(arg2)));
        let v3 = v2;
        let v4 = v1;
        if (arg3 == 0) {
            0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::checked_oracle(arg0, v0);
        } else {
            0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::dca_config::checked_keeper(arg0, v0);
        };
        (0x2::ed25519::ed25519_verify(&v3, &v4, &arg1), v0)
    }

    public fun withdraw<T0, T1>(arg0: &0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::BaseConfig, arg1: &mut Order<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x3b4723bf450f544cd50c95fee92495c9d2b0655f5d0f28f3a35b0cfbdf6cda31::base_config::checked_package_version(arg0);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 9);
        assert!(arg1.status == 0, 13);
        let v0 = 0x2::balance::value<T1>(&arg1.out_balance);
        arg1.out_withdrawn = arg1.out_withdrawn + v0;
        let v1 = WithdrawEvent{
            order_id      : 0x2::object::uid_to_inner(&arg1.id),
            user          : arg1.user,
            out_coin      : 0x1::type_name::get<T1>(),
            out_withdrawn : v0,
            withdrawn_at  : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.out_balance, v0), arg3)
    }

    // decompiled from Move bytecode v6
}

