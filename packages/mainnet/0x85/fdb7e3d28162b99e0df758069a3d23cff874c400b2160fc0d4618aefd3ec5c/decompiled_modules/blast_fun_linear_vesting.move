module 0x85fdb7e3d28162b99e0df758069a3d23cff874c400b2160fc0d4618aefd3ec5c::blast_fun_linear_vesting {
    struct Vesting<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        beneficiary: address,
        cancel_refund_recipient: 0x1::option::Option<address>,
        start_ms: u64,
        cliff_ms: u64,
        period_ms: u64,
        periods: u64,
        released: u64,
    }

    struct CancelCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vesting_id: 0x2::object::ID,
    }

    struct VestingCreated has copy, drop {
        vesting_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        beneficiary: address,
        refund_recipient: 0x1::option::Option<address>,
        cancel_cap_id: 0x1::option::Option<0x2::object::ID>,
        total_amount: u64,
        start_ms: u64,
        cliff_ms: u64,
        period_ms: u64,
        periods: u64,
    }

    struct VestingClaimed has copy, drop {
        vesting_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        beneficiary: address,
        amount: u64,
        released_total: u64,
    }

    struct VestingCanceled has copy, drop {
        vesting_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        beneficiary: address,
        refund_recipient: address,
        beneficiary_amount: u64,
        refund_amount: u64,
        released_total: u64,
    }

    struct VestingClosed has copy, drop {
        vesting_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Vesting<T0> {
        assert!(arg1 != @0x0, 13835059111844118529);
        let v0 = &arg2;
        assert!(0x1::option::is_none<address>(v0) || *0x1::option::borrow<address>(v0) != @0x0, 13835340599705862147);
        assert!(0x2::coin::value<T0>(&arg0) > 0, 13835622083272638469);
        assert!(arg5 > 0, 13835903562544447495);
        assert!(arg6 > 0, 13836185041816256521);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg7), 13838155370949115927);
        let v1 = 18446744073709551615;
        assert!(arg5 <= v1 / arg6, 13836748008949809165);
        let v2 = arg5 * arg6;
        assert!(arg4 <= v2, 13836466542562902027);
        assert!(v2 <= v1 - arg3, 13836748021834711053);
        Vesting<T0>{
            id                      : 0x2::object::new(arg8),
            balance                 : 0x2::coin::into_balance<T0>(arg0),
            beneficiary             : arg1,
            cancel_refund_recipient : arg2,
            start_ms                : arg3,
            cliff_ms                : arg4,
            period_ms               : arg5,
            periods                 : arg6,
            released                : 0,
        }
    }

    public fun cancel<T0>(arg0: Vesting<T0>, arg1: CancelCap<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vesting_id == 0x2::object::uid_to_inner(&arg0.id), 13837310559471534097);
        let v0 = vested_at<T0>(&arg0, 0x2::clock::timestamp_ms(arg2));
        let v1 = v0 - arg0.released;
        let Vesting {
            id                      : v2,
            balance                 : v3,
            beneficiary             : v4,
            cancel_refund_recipient : v5,
            start_ms                : _,
            cliff_ms                : _,
            period_ms               : _,
            periods                 : _,
            released                : _,
        } = arg0;
        let v11 = v3;
        let v12 = v2;
        let v13 = 0x1::option::destroy_some<address>(v5);
        let v14 = 0x2::balance::value<T0>(&v11) - v1;
        let CancelCap {
            id         : v15,
            vesting_id : _,
        } = arg1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, v1), arg3), v4);
        };
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v11, v14), arg3), v13);
        };
        let v17 = VestingCanceled{
            vesting_id         : 0x2::object::uid_to_inner(&v12),
            coin_type          : 0x1::type_name::with_original_ids<T0>(),
            beneficiary        : v4,
            refund_recipient   : v13,
            beneficiary_amount : v1,
            refund_amount      : v14,
            released_total     : v0,
        };
        0x2::event::emit<VestingCanceled>(v17);
        0x2::balance::destroy_zero<T0>(v11);
        0x2::object::delete(v12);
        0x2::object::delete(v15);
    }

    public fun claim<T0>(arg0: &mut Vesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = vested_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.released;
        assert!(v0 > 0, 13837028994300379151);
        arg0.released = arg0.released + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2), arg0.beneficiary);
        let v1 = VestingClaimed{
            vesting_id     : 0x2::object::uid_to_inner(&arg0.id),
            coin_type      : 0x1::type_name::with_original_ids<T0>(),
            beneficiary    : arg0.beneficiary,
            amount         : v0,
            released_total : arg0.released,
        };
        0x2::event::emit<VestingClaimed>(v1);
    }

    public fun close_irrevocable<T0>(arg0: Vesting<T0>) {
        assert!(0x1::option::is_none<address>(&arg0.cancel_refund_recipient), 13837873702698745877);
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 13837592232016871443);
        let Vesting {
            id                      : v0,
            balance                 : v1,
            beneficiary             : _,
            cancel_refund_recipient : _,
            start_ms                : _,
            cliff_ms                : _,
            period_ms               : _,
            periods                 : _,
            released                : _,
        } = arg0;
        let v9 = v0;
        let v10 = VestingClosed{
            vesting_id : 0x2::object::uid_to_inner(&v9),
            coin_type  : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<VestingClosed>(v10);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::object::delete(v9);
    }

    fun emit_created<T0>(arg0: &Vesting<T0>, arg1: 0x1::option::Option<0x2::object::ID>) {
        let v0 = VestingCreated{
            vesting_id       : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : 0x1::type_name::with_original_ids<T0>(),
            beneficiary      : arg0.beneficiary,
            refund_recipient : arg0.cancel_refund_recipient,
            cancel_cap_id    : arg1,
            total_amount     : 0x2::balance::value<T0>(&arg0.balance),
            start_ms         : arg0.start_ms,
            cliff_ms         : arg0.cliff_ms,
            period_ms        : arg0.period_ms,
            periods          : arg0.periods,
        };
        0x2::event::emit<VestingCreated>(v0);
    }

    public fun new_cancelable<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (Vesting<T0>, CancelCap<T0>) {
        let v0 = new<T0>(arg0, arg1, 0x1::option::some<address>(arg2), arg3, arg4, arg5, arg6, arg7, arg8);
        let v1 = CancelCap<T0>{
            id         : 0x2::object::new(arg8),
            vesting_id : 0x2::object::uid_to_inner(&v0.id),
        };
        emit_created<T0>(&v0, 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v1.id)));
        (v0, v1)
    }

    public fun new_irrevocable<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Vesting<T0> {
        let v0 = new<T0>(arg0, arg1, 0x1::option::none<address>(), arg2, arg3, arg4, arg5, arg6, arg7);
        emit_created<T0>(&v0, 0x1::option::none<0x2::object::ID>());
        v0
    }

    public fun share<T0>(arg0: Vesting<T0>) {
        0x2::transfer::share_object<Vesting<T0>>(arg0);
    }

    fun vested_at<T0>(arg0: &Vesting<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.start_ms + arg0.cliff_ms) {
            return 0
        };
        if (arg1 >= arg0.start_ms + arg0.period_ms * arg0.periods) {
            return 0x2::balance::value<T0>(&arg0.balance) + arg0.released
        };
        0x1::u64::mul_div(0x2::balance::value<T0>(&arg0.balance) + arg0.released, (arg1 - arg0.start_ms) / arg0.period_ms, arg0.periods)
    }

    // decompiled from Move bytecode v7
}

