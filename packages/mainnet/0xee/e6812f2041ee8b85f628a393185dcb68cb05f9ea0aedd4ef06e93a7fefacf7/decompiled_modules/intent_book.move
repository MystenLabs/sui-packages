module 0xeee6812f2041ee8b85f628a393185dcb68cb05f9ea0aedd4ef06e93a7fefacf7::intent_book {
    struct IntentCreatedEvent has copy, drop {
        intent_id: 0x2::object::ID,
        owner: address,
        sell_type: 0x1::type_name::TypeName,
        buy_type: 0x1::type_name::TypeName,
        sell_amount: u64,
        min_amount_out: u64,
        partial_fillable: bool,
        target_epoch: u64,
        deadline: u64,
    }

    struct IntentCancelledEvent has copy, drop {
        intent_id: 0x2::object::ID,
        owner: address,
        sell_amount: u64,
    }

    struct IntentUpdatedEvent has copy, drop {
        intent_id: 0x2::object::ID,
        owner: address,
        new_min_amount_out: u64,
        new_target_epoch: u64,
        new_deadline: u64,
    }

    struct Intent<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        sell_balance: 0x2::balance::Balance<T0>,
        min_amount_out: u64,
        partial_fillable: bool,
        filled_amount: u64,
        target_epoch: u64,
        deadline: u64,
    }

    public(friend) fun cancel_intent<T0, T1>(arg0: Intent<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let Intent {
            id               : v0,
            owner            : v1,
            sell_balance     : v2,
            min_amount_out   : _,
            partial_fillable : _,
            filled_amount    : _,
            target_epoch     : _,
            deadline         : _,
        } = arg0;
        assert!(v1 == 0x2::tx_context::sender(arg1), 1);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg1), v1);
        let v8 = IntentCancelledEvent{
            intent_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner       : v1,
            sell_amount : 0x2::balance::value<T0>(&arg0.sell_balance),
        };
        0x2::event::emit<IntentCancelledEvent>(v8);
    }

    public(friend) fun consume_intent<T0, T1>(arg0: Intent<T0, T1>) : (address, 0x2::balance::Balance<T0>, u64) {
        let Intent {
            id               : v0,
            owner            : v1,
            sell_balance     : v2,
            min_amount_out   : v3,
            partial_fillable : _,
            filled_amount    : _,
            target_epoch     : _,
            deadline         : _,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public(friend) fun consume_intent_partial<T0, T1>(arg0: &mut Intent<T0, T1>, arg1: u64) : (address, 0x2::balance::Balance<T0>, u64) {
        assert!(arg0.partial_fillable, 3);
        let v0 = 0x2::balance::value<T0>(&arg0.sell_balance);
        assert!(arg1 > 0 && arg1 <= v0, 4);
        arg0.filled_amount = arg0.filled_amount + arg1;
        (arg0.owner, 0x2::balance::split<T0>(&mut arg0.sell_balance, arg1), (((arg0.min_amount_out as u128) * (arg1 as u128) / ((v0 + arg0.filled_amount) as u128)) as u64))
    }

    public(friend) fun create_intent<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = Intent<T0, T1>{
            id               : 0x2::object::new(arg6),
            owner            : v0,
            sell_balance     : 0x2::coin::into_balance<T0>(arg0),
            min_amount_out   : arg1,
            partial_fillable : arg2,
            filled_amount    : 0,
            target_epoch     : arg3,
            deadline         : arg4,
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x2::transfer::share_object<Intent<T0, T1>>(v1);
        let v3 = IntentCreatedEvent{
            intent_id        : v2,
            owner            : v0,
            sell_type        : 0x1::type_name::with_defining_ids<T0>(),
            buy_type         : 0x1::type_name::with_defining_ids<T1>(),
            sell_amount      : 0x2::coin::value<T0>(&arg0),
            min_amount_out   : arg1,
            partial_fillable : arg2,
            target_epoch     : arg3,
            deadline         : arg4,
        };
        0x2::event::emit<IntentCreatedEvent>(v3);
        v2
    }

    public fun deadline<T0, T1>(arg0: &Intent<T0, T1>) : u64 {
        arg0.deadline
    }

    public fun filled_amount<T0, T1>(arg0: &Intent<T0, T1>) : u64 {
        arg0.filled_amount
    }

    public fun id<T0, T1>(arg0: &Intent<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun increment_target_epoch<T0, T1>(arg0: &mut Intent<T0, T1>) {
        arg0.target_epoch = arg0.target_epoch + 1;
    }

    public fun min_amount_out<T0, T1>(arg0: &Intent<T0, T1>) : u64 {
        arg0.min_amount_out
    }

    public fun owner<T0, T1>(arg0: &Intent<T0, T1>) : address {
        arg0.owner
    }

    public fun partial_fillable<T0, T1>(arg0: &Intent<T0, T1>) : bool {
        arg0.partial_fillable
    }

    public fun sell_amount<T0, T1>(arg0: &Intent<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.sell_balance)
    }

    public fun target_epoch<T0, T1>(arg0: &Intent<T0, T1>) : u64 {
        arg0.target_epoch
    }

    public(friend) fun update_intent_params<T0, T1>(arg0: &mut Intent<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 1);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg4), 0);
        arg0.min_amount_out = arg1;
        arg0.target_epoch = arg2;
        arg0.deadline = arg3;
        let v0 = IntentUpdatedEvent{
            intent_id          : 0x2::object::uid_to_inner(&arg0.id),
            owner              : arg0.owner,
            new_min_amount_out : arg1,
            new_target_epoch   : arg2,
            new_deadline       : arg3,
        };
        0x2::event::emit<IntentUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

