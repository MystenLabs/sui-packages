module 0x85fdb7e3d28162b99e0df758069a3d23cff874c400b2160fc0d4618aefd3ec5c::blast_fun_checkpoint_vesting {
    struct Checkpoint has drop, store {
        timestamp_ms: u64,
        cumulative_amount: u64,
    }

    struct Schedule {
        checkpoints: vector<Checkpoint>,
    }

    struct Vesting<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        beneficiary: address,
        cancel_refund_recipient: 0x1::option::Option<address>,
        checkpoints: vector<Checkpoint>,
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
        checkpoint_count: u64,
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

    fun new<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: Schedule, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Vesting<T0> {
        assert!(arg1 != @0x0, 13835059189153595394);
        let v0 = &arg2;
        assert!(0x1::option::is_none<address>(v0) || *0x1::option::borrow<address>(v0) != @0x0, 13835340677015339012);
        let v1 = 0x2::coin::value<T0>(&arg0);
        assert!(v1 > 0, 13835622164877082630);
        let Schedule { checkpoints: v2 } = arg3;
        assert!(!0x1::vector::is_empty<Checkpoint>(&v2), 13835903648443858952);
        assert!(0x1::vector::borrow<Checkpoint>(&v2, 0).timestamp_ms >= 0x2::clock::timestamp_ms(arg4), 13836466602692509708);
        assert!(0x1::vector::borrow<Checkpoint>(&v2, 0x1::vector::length<Checkpoint>(&v2) - 1).cumulative_amount == v1, 13837311040507936786);
        Vesting<T0>{
            id                      : 0x2::object::new(arg5),
            balance                 : 0x2::coin::into_balance<T0>(arg0),
            beneficiary             : arg1,
            cancel_refund_recipient : arg2,
            checkpoints             : v2,
            released                : 0,
        }
    }

    public fun add(arg0: &mut Schedule, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::length<Checkpoint>(&arg0.checkpoints);
        assert!(v0 < 256, 13836184346031620106);
        if (v0 == 0) {
            assert!(arg2 > 0, 13837028779552079888);
        } else {
            let v1 = 0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v0 - 1);
            assert!(arg1 > v1.timestamp_ms, 13836747326050074638);
            assert!(arg2 > v1.cumulative_amount, 13837028818206785552);
        };
        let v2 = Checkpoint{
            timestamp_ms      : arg1,
            cumulative_amount : arg2,
        };
        0x1::vector::push_back<Checkpoint>(&mut arg0.checkpoints, v2);
    }

    public fun cancel<T0>(arg0: Vesting<T0>, arg1: CancelCap<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vesting_id == 0x2::object::uid_to_inner(&arg0.id), 13837873625389400086);
        let v0 = vested_at<T0>(&arg0, 0x2::clock::timestamp_ms(arg2));
        let v1 = v0 - arg0.released;
        let Vesting {
            id                      : v2,
            balance                 : v3,
            beneficiary             : v4,
            cancel_refund_recipient : v5,
            checkpoints             : _,
            released                : _,
        } = arg0;
        let v8 = v3;
        let v9 = v2;
        let v10 = 0x1::option::destroy_some<address>(v5);
        let v11 = 0x2::balance::value<T0>(&v8) - v1;
        let CancelCap {
            id         : v12,
            vesting_id : _,
        } = arg1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v1), arg3), v4);
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v11), arg3), v10);
        };
        let v14 = VestingCanceled{
            vesting_id         : 0x2::object::uid_to_inner(&v9),
            coin_type          : 0x1::type_name::with_original_ids<T0>(),
            beneficiary        : v4,
            refund_recipient   : v10,
            beneficiary_amount : v1,
            refund_amount      : v11,
            released_total     : v0,
        };
        0x2::event::emit<VestingCanceled>(v14);
        0x2::balance::destroy_zero<T0>(v8);
        0x2::object::delete(v9);
        0x2::object::delete(v12);
    }

    public fun claim<T0>(arg0: &mut Vesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = vested_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.released;
        assert!(v0 > 0, 13837592060218245140);
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
        assert!(0x1::option::is_none<address>(&arg0.cancel_refund_recipient), 13838436755731709978);
        assert!(0x2::balance::value<T0>(&arg0.balance) == 0, 13838155285049835544);
        let Vesting {
            id                      : v0,
            balance                 : v1,
            beneficiary             : _,
            cancel_refund_recipient : _,
            checkpoints             : _,
            released                : _,
        } = arg0;
        let v6 = v0;
        let v7 = VestingClosed{
            vesting_id : 0x2::object::uid_to_inner(&v6),
            coin_type  : 0x1::type_name::with_original_ids<T0>(),
        };
        0x2::event::emit<VestingClosed>(v7);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::object::delete(v6);
    }

    fun emit_created<T0>(arg0: &Vesting<T0>, arg1: 0x1::option::Option<0x2::object::ID>) {
        let v0 = VestingCreated{
            vesting_id       : 0x2::object::uid_to_inner(&arg0.id),
            coin_type        : 0x1::type_name::with_original_ids<T0>(),
            beneficiary      : arg0.beneficiary,
            refund_recipient : arg0.cancel_refund_recipient,
            cancel_cap_id    : arg1,
            total_amount     : 0x2::balance::value<T0>(&arg0.balance),
            checkpoint_count : 0x1::vector::length<Checkpoint>(&arg0.checkpoints),
        };
        0x2::event::emit<VestingCreated>(v0);
    }

    public fun new_cancelable<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: address, arg3: Schedule, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (Vesting<T0>, CancelCap<T0>) {
        let v0 = new<T0>(arg0, arg1, 0x1::option::some<address>(arg2), arg3, arg4, arg5);
        let v1 = CancelCap<T0>{
            id         : 0x2::object::new(arg5),
            vesting_id : 0x2::object::uid_to_inner(&v0.id),
        };
        emit_created<T0>(&v0, 0x1::option::some<0x2::object::ID>(0x2::object::uid_to_inner(&v1.id)));
        (v0, v1)
    }

    public fun new_irrevocable<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: Schedule, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Vesting<T0> {
        let v0 = new<T0>(arg0, arg1, 0x1::option::none<address>(), arg2, arg3, arg4);
        emit_created<T0>(&v0, 0x1::option::none<0x2::object::ID>());
        v0
    }

    public fun new_schedule() : Schedule {
        Schedule{checkpoints: 0x1::vector::empty<Checkpoint>()}
    }

    public fun share<T0>(arg0: Vesting<T0>) {
        0x2::transfer::share_object<Vesting<T0>>(arg0);
    }

    fun vested_at<T0>(arg0: &Vesting<T0>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Checkpoint>(&arg0.checkpoints);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            if (0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v1).timestamp_ms <= arg1) {
                v0 = v1 + 1;
                continue
            };
        };
        if (v0 == 0) {
            0
        } else {
            0x1::vector::borrow<Checkpoint>(&arg0.checkpoints, v0 - 1).cumulative_amount
        }
    }

    // decompiled from Move bytecode v7
}

