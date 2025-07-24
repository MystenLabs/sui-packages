module 0x8f70ad5db84e1a99b542f86ccfb1a932ca7ba010a2fa12a1504d839ff4c111c6::moonbags_token_lock {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Configuration has store, key {
        id: 0x2::object::UID,
        lock_fee: u64,
        admin: address,
    }

    struct LockContract<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        amount: u64,
        start_time: u64,
        end_time: u64,
        locker: address,
        recipient: address,
        closed: bool,
    }

    struct LockCreatedEvent has copy, drop {
        contract_id: address,
        token_address: 0x1::ascii::String,
        locker: address,
        recipient: address,
        amount: u64,
        fee: u64,
        start_time: u64,
        end_time: u64,
    }

    struct TokensWithdrawnEvent has copy, drop {
        contract_id: address,
        sender: address,
        recipient: address,
        amount: u64,
    }

    public entry fun create_lock<T0>(arg0: &Configuration, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 >= 10000, 4);
        assert!(arg4 > v0, 4);
        let v1 = arg3 * arg0.lock_fee / 10000;
        assert!(0x2::coin::value<T0>(&arg1) >= arg3 + v1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg6), arg0.admin);
        let v2 = LockContract<T0>{
            id         : 0x2::object::new(arg6),
            balance    : 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg3, arg6)),
            amount     : arg3,
            start_time : v0,
            end_time   : arg4,
            locker     : 0x2::tx_context::sender(arg6),
            recipient  : arg2,
            closed     : false,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg6));
        let v3 = LockCreatedEvent{
            contract_id   : 0x2::object::uid_to_address(&v2.id),
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            locker        : 0x2::tx_context::sender(arg6),
            recipient     : arg2,
            amount        : arg3,
            fee           : v1,
            start_time    : v0,
            end_time      : arg4,
        };
        0x2::event::emit<LockCreatedEvent>(v3);
        0x2::transfer::share_object<LockContract<T0>>(v2);
    }

    public entry fun extend_lock<T0>(arg0: &mut LockContract<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.locker, 3);
        assert!(!arg0.closed, 1);
        assert!(arg1 > arg0.end_time, 4);
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 4);
        arg0.end_time = arg1;
        let v0 = LockCreatedEvent{
            contract_id   : 0x2::object::uid_to_address(&arg0.id),
            token_address : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            locker        : arg0.locker,
            recipient     : arg0.recipient,
            amount        : arg0.amount,
            fee           : 0,
            start_time    : arg0.start_time,
            end_time      : arg0.end_time,
        };
        0x2::event::emit<LockCreatedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Configuration{
            id       : 0x2::object::new(arg0),
            lock_fee : 0,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Configuration>(v1);
    }

    public entry fun update_config(arg0: &AdminCap, arg1: &mut Configuration, arg2: u64, arg3: address) {
        assert!(arg2 <= 10000, 5);
        arg1.lock_fee = arg2;
        arg1.admin = arg3;
    }

    public entry fun withdraw<T0>(arg0: &Configuration, arg1: &mut LockContract<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (v0 == arg0.admin) {
            true
        } else if (v0 == arg1.recipient) {
            true
        } else {
            v0 == arg1.locker
        };
        assert!(v1, 3);
        assert!(!arg1.closed, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_time, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg3), arg1.recipient);
        arg1.closed = true;
        let v2 = TokensWithdrawnEvent{
            contract_id : 0x2::object::uid_to_address(&arg1.id),
            sender      : v0,
            recipient   : arg1.recipient,
            amount      : 0x2::balance::value<T0>(&arg1.balance),
        };
        0x2::event::emit<TokensWithdrawnEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

