module 0x4fdec220db31a67a8c4440dcb3f48882bce645f68e354c94b7cc2dbe964ac992::miraidrop {
    struct MiraiDrop<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        balance_allocated: u64,
        lifecycle: Lifecycle,
        recipients: 0x2::linked_table::LinkedTable<address, u64>,
    }

    struct Lifecycle has store {
        is_initialized: bool,
        is_execution_started: bool,
        is_execution_completed: bool,
    }

    struct CreatedEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
        type_name: 0x1::string::String,
    }

    struct DepositEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
        amount: u64,
    }

    struct InitializeEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
        amount: u64,
    }

    struct RecipientAddedEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct RecipientRemovedEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct UninitializeEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
    }

    struct ExecutedEvent has copy, drop {
        miraidrop_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public fun destroy_empty<T0: drop>(arg0: MiraiDrop<T0>) {
        assert!(arg0.lifecycle.is_execution_completed == true, 6);
        let MiraiDrop {
            id                : v0,
            balance           : v1,
            balance_allocated : _,
            lifecycle         : v3,
            recipients        : v4,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::linked_table::destroy_empty<address, u64>(v4);
        let Lifecycle {
            is_initialized         : _,
            is_execution_started   : _,
            is_execution_completed : _,
        } = v3;
    }

    public fun balance<T0: drop>(arg0: &MiraiDrop<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun withdraw_all<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.lifecycle.is_initialized == false, 0);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg1);
        let v1 = WithdrawEvent{
            miraidrop_id : id<T0>(arg0),
            amount       : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        v0
    }

    entry fun new<T0: drop>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Lifecycle{
            is_initialized         : false,
            is_execution_started   : false,
            is_execution_completed : false,
        };
        let v1 = MiraiDrop<T0>{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<T0>(),
            balance_allocated : 0,
            lifecycle         : v0,
            recipients        : 0x2::linked_table::new<address, u64>(arg0),
        };
        let v2 = CreatedEvent{
            miraidrop_id : 0x2::object::id<MiraiDrop<T0>>(&v1),
            type_name    : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<CreatedEvent>(v2);
        0x2::transfer::transfer<MiraiDrop<T0>>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun id<T0: drop>(arg0: &MiraiDrop<T0>) : 0x2::object::ID {
        0x2::object::id<MiraiDrop<T0>>(arg0)
    }

    public fun add_recipient<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: address, arg2: u64) {
        assert!(!0x2::linked_table::contains<address, u64>(&arg0.recipients, arg1), 2);
        let v0 = RecipientAddedEvent{
            miraidrop_id : id<T0>(arg0),
            recipient    : arg1,
            amount       : arg2,
        };
        0x2::event::emit<RecipientAddedEvent>(v0);
        0x2::linked_table::push_back<address, u64>(&mut arg0.recipients, arg1, arg2);
        arg0.balance_allocated = arg0.balance_allocated + arg2;
    }

    public fun balance_allocated<T0: drop>(arg0: &MiraiDrop<T0>) : u64 {
        arg0.balance_allocated
    }

    public fun deposit<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert!(arg0.lifecycle.is_initialized == false, 0);
        let v0 = DepositEvent{
            miraidrop_id : id<T0>(arg0),
            amount       : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun execute<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.lifecycle.is_initialized == true, 4);
        if (arg0.lifecycle.is_execution_started == false) {
            arg0.lifecycle.is_execution_started = true;
        };
        let v0 = 0;
        while (v0 < 0x1::u64::min(arg1, 0x2::linked_table::length<address, u64>(&arg0.recipients))) {
            let (v1, v2) = 0x2::linked_table::pop_back<address, u64>(&mut arg0.recipients);
            let v3 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v2), arg2);
            let v4 = ExecutedEvent{
                miraidrop_id : id<T0>(arg0),
                recipient    : v1,
                amount       : 0x2::coin::value<T0>(&v3),
            };
            0x2::event::emit<ExecutedEvent>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
            v0 = v0 + 1;
        };
        if (0x2::linked_table::length<address, u64>(&arg0.recipients) == 0) {
            arg0.lifecycle.is_execution_completed = true;
        };
    }

    public fun initialize<T0: drop>(arg0: &mut MiraiDrop<T0>) {
        assert!(arg0.lifecycle.is_initialized == false, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) == arg0.balance_allocated, 3);
        let v0 = InitializeEvent{miraidrop_id: id<T0>(arg0)};
        0x2::event::emit<InitializeEvent>(v0);
        arg0.lifecycle.is_initialized = true;
    }

    public fun is_execution_completed<T0: drop>(arg0: &MiraiDrop<T0>) : bool {
        arg0.lifecycle.is_execution_completed
    }

    public fun is_execution_started<T0: drop>(arg0: &MiraiDrop<T0>) : bool {
        arg0.lifecycle.is_execution_started
    }

    public fun is_initialized<T0: drop>(arg0: &MiraiDrop<T0>) : bool {
        arg0.lifecycle.is_initialized
    }

    public fun recipients<T0: drop>(arg0: &MiraiDrop<T0>) : &0x2::linked_table::LinkedTable<address, u64> {
        &arg0.recipients
    }

    public fun remove_recipient<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.lifecycle.is_initialized == false, 0);
        let v0 = 0x2::linked_table::remove<address, u64>(&mut arg0.recipients, arg1);
        arg0.balance_allocated = arg0.balance_allocated - v0;
        let v1 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2);
        let v2 = RecipientRemovedEvent{
            miraidrop_id : id<T0>(arg0),
            recipient    : arg1,
            amount       : 0x2::coin::value<T0>(&v1),
        };
        0x2::event::emit<RecipientRemovedEvent>(v2);
        v1
    }

    public fun remove_recipients<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        while (v1 < 0x1::u64::min(arg1, 0x2::linked_table::length<address, u64>(&arg0.recipients))) {
            let (v2, v3) = 0x2::linked_table::pop_back<address, u64>(&mut arg0.recipients);
            arg0.balance_allocated = arg0.balance_allocated - v3;
            let v4 = 0x2::balance::split<T0>(&mut arg0.balance, v3);
            let v5 = RecipientRemovedEvent{
                miraidrop_id : id<T0>(arg0),
                recipient    : v2,
                amount       : 0x2::balance::value<T0>(&v4),
            };
            0x2::event::emit<RecipientRemovedEvent>(v5);
            0x2::balance::join<T0>(&mut v0, v4);
            v1 = v1 + 1;
        };
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    public fun uninitialize<T0: drop>(arg0: &mut MiraiDrop<T0>) {
        assert!(arg0.lifecycle.is_initialized == true, 4);
        assert!(arg0.lifecycle.is_execution_started == false, 5);
        let v0 = UninitializeEvent{miraidrop_id: id<T0>(arg0)};
        0x2::event::emit<UninitializeEvent>(v0);
        arg0.lifecycle.is_initialized = false;
    }

    public fun withdraw<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.lifecycle.is_initialized == false, 0);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2);
        let v1 = WithdrawEvent{
            miraidrop_id : id<T0>(arg0),
            amount       : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        v0
    }

    public fun withdraw_excess<T0: drop>(arg0: &mut MiraiDrop<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.lifecycle.is_initialized == false, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) > arg0.balance_allocated, 1);
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance) - arg0.balance_allocated), arg1);
        let v1 = WithdrawEvent{
            miraidrop_id : id<T0>(arg0),
            amount       : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

