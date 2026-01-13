module 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::dca {
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

    struct MakeDealReceipt {
        order_id: 0x2::object::ID,
        in_amount: u64,
        promise_out_amount: u64,
        fee_amount: u64,
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

    public fun cancel_order<T0, T1>(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: &mut Order<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::checked_package_version(arg0);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_unauthorized_user());
        assert!(arg1.status == 0, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_invalid_order_status());
        let v0 = 0x2::balance::value<T0>(&arg1.in_balance);
        let v1 = 0x2::balance::value<T1>(&arg1.out_balance);
        arg1.in_withdrawn = arg1.in_withdrawn + v0;
        arg1.out_withdrawn = arg1.out_withdrawn + v1;
        arg1.next_cycle_at = 0;
        arg1.amount_left_next_cycle = 0;
        arg1.status = 2;
        let v2 = CancelOrderEvent{
            order_id      : 0x2::object::uid_to_inner(&arg1.id),
            user          : arg1.user,
            in_coin       : 0x1::type_name::with_defining_ids<T0>(),
            out_coin      : 0x1::type_name::with_defining_ids<T1>(),
            in_withdrawn  : v0,
            out_withdrawn : v1,
            closed_at     : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<CancelOrderEvent>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.in_balance, v0), arg3), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.out_balance, v1), arg3))
    }

    public fun flash_loan_for_make_deal<T0, T1>(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: &mut 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::ProtocolFeeVault, arg2: &mut Order<T0, T1>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, MakeDealReceipt) {
        0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::checked_package_version(arg0);
        assert!(arg2.status == 0, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_invalid_order_status());
        assert!(validate_execution_permission<T0, T1>(arg0, arg2, arg3, 0x2::tx_context::sender(arg7), arg4, arg5, arg6), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_execution_permission_failed());
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        assert!(arg2.amount_left_next_cycle > 0, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_no_amount_left_next_cycle());
        assert!(v0 >= arg2.next_cycle_at, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_current_time_before_next_cycle());
        let v1 = 0x2::balance::split<T0>(&mut arg2.in_balance, arg2.amount_left_next_cycle);
        let v2 = if (arg2.fee_rate > 0) {
            let v3 = (((0x2::balance::value<T0>(&v1) as u128) * (arg2.fee_rate as u128) / 1000000) as u64);
            0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::receive_fee<T0>(arg1, 0x2::balance::split<T0>(&mut v1, v3));
            v3
        } else {
            0
        };
        let v4 = if (0x2::balance::value<T0>(&arg2.in_balance) >= arg2.in_amount_per_cycle * 2) {
            arg2.in_amount_per_cycle
        } else {
            0x2::balance::value<T0>(&arg2.in_balance)
        };
        arg2.amount_left_next_cycle = v4;
        if (arg2.amount_left_next_cycle > 0) {
            arg2.next_cycle_at = v0 + arg2.cycle_frequency;
        } else {
            arg2.next_cycle_at = 0;
        };
        let v5 = MakeDealReceipt{
            order_id           : 0x2::object::uid_to_inner(&arg2.id),
            in_amount          : arg2.amount_left_next_cycle,
            promise_out_amount : arg3,
            fee_amount         : v2,
        };
        (0x2::coin::from_balance<T0>(v1, arg7), v5)
    }

    public fun open_order<T0, T1>(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::checked_package_version(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1) / arg3;
        validate_order<T0, T1>(0x2::tx_context::sender(arg11), arg0, v0, arg6, arg2, arg3, arg7, arg8, arg9, arg10);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg10) / 1000;
        let v3 = 0x2::balance::value<T0>(&v1);
        let v4 = 0x2::tx_context::sender(arg11);
        let v5 = Order<T0, T1>{
            id                       : 0x2::object::new(arg11),
            user                     : v4,
            in_deposited             : v3,
            in_withdrawn             : 0,
            out_withdrawn            : 0,
            in_balance               : v1,
            out_balance              : 0x2::balance::zero<T1>(),
            cycle_frequency          : arg2,
            in_amount_per_cycle      : v3 / arg3,
            amount_left_next_cycle   : v0,
            next_cycle_at            : v2,
            min_out_amount_per_cycle : arg4,
            max_out_amount_per_cycle : arg5,
            fee_rate                 : arg7,
            status                   : 0,
            created_at               : v2,
        };
        0x2::transfer::share_object<Order<T0, T1>>(v5);
        let v6 = OpenOrderEvent{
            order_id                  : 0x2::object::uid_to_inner(&v5.id),
            user                      : v4,
            in_coin                   : 0x1::type_name::with_defining_ids<T0>(),
            out_coin                  : 0x1::type_name::with_defining_ids<T1>(),
            in_deposited              : v3,
            cycle_count               : arg3,
            cycle_frequency           : arg2,
            in_amount_per_cycle       : v3 / arg3,
            in_amount_limit_per_cycle : arg6,
            min_out_amount_per_cycle  : arg4,
            max_out_amount_per_cycle  : arg5,
            fee_rate                  : arg7,
            created_at                : v2,
        };
        0x2::event::emit<OpenOrderEvent>(v6);
    }

    fun parse_signature(arg0: vector<u8>) : (address, vector<u8>, vector<u8>) {
        assert!(*0x1::vector::borrow<u8>(&arg0, 0) == 0, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_invalid_signature_format());
        let v0 = x"00";
        let v1 = b"";
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

    public fun repay_for_make_deal<T0, T1>(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: &mut Order<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: MakeDealReceipt, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::checked_package_version(arg0);
        assert!(arg3.order_id == 0x2::object::uid_to_inner(&arg1.id), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_receipt_order_id_mismatch());
        assert!(arg1.status == 0, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_invalid_order_status());
        let MakeDealReceipt {
            order_id           : v0,
            in_amount          : v1,
            promise_out_amount : v2,
            fee_amount         : v3,
        } = arg3;
        let v4 = 0x2::coin::value<T1>(&arg2);
        assert!(v4 >= v2, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_output_amount_below_promised());
        assert!(v4 >= arg1.min_out_amount_per_cycle, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_output_amount_below_minimum());
        assert!(v4 <= arg1.max_out_amount_per_cycle, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_output_amount_above_maximum());
        let v5 = 0x2::clock::timestamp_ms(arg4) / 1000;
        0x2::balance::join<T1>(&mut arg1.out_balance, 0x2::coin::into_balance<T1>(arg2));
        let v6 = MakeDealEvent{
            order_id           : v0,
            user               : arg1.user,
            in_coin            : 0x1::type_name::with_defining_ids<T0>(),
            out_coin           : 0x1::type_name::with_defining_ids<T1>(),
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
            let v7 = 0x2::balance::value<T1>(&arg1.out_balance);
            arg1.out_withdrawn = arg1.out_withdrawn + v7;
            arg1.status = 1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.out_balance, v7), arg5), arg1.user);
            let v8 = CloseOrderEvent{
                order_id      : v0,
                user          : arg1.user,
                out_coin      : 0x1::type_name::with_defining_ids<T1>(),
                out_withdrawn : v7,
                closed_at     : v5,
            };
            0x2::event::emit<CloseOrderEvent>(v8);
        };
    }

    fun validate_execution_permission<T0, T1>(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: &Order<T0, T1>, arg2: u64, arg3: address, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg6) / 1000;
        let v1 = if (v0 > arg4) {
            v0 - arg4
        } else {
            arg4 - v0
        };
        assert!(v1 <= 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::oracle_valid_duration(arg0), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_oracle_signature_expired());
        let v2 = 0x2::object::id_bytes<Order<T0, T1>>(arg1);
        0x1::vector::append<u8>(&mut v2, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())));
        0x1::vector::append<u8>(&mut v2, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>())));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg1.next_cycle_at));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg1.amount_left_next_cycle));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(arg3));
        let (v3, _) = verify_internal(arg0, v2, &arg5);
        v3
    }

    fun validate_order<T0, T1>(arg0: address, arg1: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0x2::clock::Clock) {
        assert!(0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::is_coin_allow<T0, T1>(arg1), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_coin_type_not_allowed());
        assert!(arg5 >= 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::min_cycle_count(arg1), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_cycle_count_below_minimum());
        assert!(arg2 > arg3, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_amount_per_cycle_le_limit());
        assert!(arg4 >= 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::min_cycle_frequency(arg1), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_cycle_frequency_below_minimum());
        let v0 = 0x2::clock::timestamp_ms(arg9) / 1000;
        let v1 = if (v0 > arg7) {
            v0 - arg7
        } else {
            arg7 - v0
        };
        assert!(v1 <= 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::oracle_valid_duration(arg1), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_oracle_signature_expired());
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(arg0));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg6));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<u64>(&arg7));
        let (v3, _) = verify_internal(arg1, v2, &arg8);
        assert!(v3, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_invalid_oracle_signature());
    }

    fun verify_internal(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: vector<u8>, arg2: &0x1::string::String) : (bool, address) {
        let (v0, v1, v2) = parse_signature(0x2::hex::decode(*0x1::string::as_bytes(arg2)));
        let v3 = v2;
        let v4 = v1;
        0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::checked_oracle(arg0, v0);
        (0x2::ed25519::ed25519_verify(&v3, &v4, &arg1), v0)
    }

    public fun withdraw<T0, T1>(arg0: &0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::GlobalConfig, arg1: &mut Order<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::config::checked_package_version(arg0);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_unauthorized_user());
        assert!(arg1.status == 0, 0x7275a7bc220a36d0b38724d7c92b08a01538dcfb17ca3d58b14eee2a40edcdc::error::e_invalid_order_status());
        let v0 = 0x2::balance::value<T1>(&arg1.out_balance);
        arg1.out_withdrawn = arg1.out_withdrawn + v0;
        let v1 = WithdrawEvent{
            order_id      : 0x2::object::uid_to_inner(&arg1.id),
            user          : arg1.user,
            out_coin      : 0x1::type_name::with_defining_ids<T1>(),
            out_withdrawn : v0,
            withdrawn_at  : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.out_balance, v0), arg3)
    }

    // decompiled from Move bytecode v6
}

