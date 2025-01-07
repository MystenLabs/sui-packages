module 0x6c38fa662e97fc659e1e9181b074342fe398f5dca6b64e428e927df0bf2883a4::flip_coin {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<T0>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TransEvent has copy, drop {
        caller: address,
        amount_change: u64,
        direction: 0x1::string::String,
        pool_balance: u64,
        coin_type: 0x1::string::String,
    }

    public entry fun batch_deposit<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: vector<0x2::coin::Coin<T0>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg2)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg2));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg2);
        0x2::balance::join<T0>(&mut arg0.amount, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, arg1, arg3)));
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        let v1 = TransEvent{
            caller        : 0x2::tx_context::sender(arg3),
            amount_change : arg1,
            direction     : 0x1::string::utf8(b"in"),
            pool_balance  : 0x2::balance::value<T0>(&arg0.amount),
            coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TransEvent>(v1);
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::coin::value<T0>(&arg1) <= arg2) {
            0x2::balance::join<T0>(&mut arg0.amount, 0x2::coin::into_balance<T0>(arg1));
            0x2::coin::value<T0>(&arg1)
        } else {
            0x2::balance::join<T0>(&mut arg0.amount, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
            arg2
        };
        let v1 = TransEvent{
            caller        : 0x2::tx_context::sender(arg3),
            amount_change : v0,
            direction     : 0x1::string::utf8(b"in"),
            pool_balance  : 0x2::balance::value<T0>(&arg0.amount),
            coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TransEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id     : 0x2::object::new(arg1),
            amount : 0x2::coin::into_balance<T0>(arg0),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    entry fun play<T0>(arg0: &0x2::random::Random, arg1: &mut Vault<T0>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::coin::value<T0>(&arg3) > arg4) {
            let v0 = 0x2::coin::split<T0>(&mut arg3, arg4, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg5));
            v0
        } else {
            arg3
        };
        let v1 = 0x2::random::new_generator(arg0, arg5);
        let v2 = 0x2::coin::value<T0>(&v0);
        assert!(0x2::balance::value<T0>(&arg1.amount) >= v2 * 10, 1);
        let v3 = if (arg2 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, v2), arg5), 0x2::tx_context::sender(arg5));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
            b"out"
        } else {
            0x2::balance::join<T0>(&mut arg1.amount, 0x2::coin::into_balance<T0>(v0));
            b"in"
        };
        let v4 = TransEvent{
            caller        : 0x2::tx_context::sender(arg5),
            amount_change : v2,
            direction     : 0x1::string::utf8(v3),
            pool_balance  : 0x2::balance::value<T0>(&arg1.amount),
            coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TransEvent>(v4);
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.amount) > arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.amount, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = TransEvent{
            caller        : 0x2::tx_context::sender(arg3),
            amount_change : arg2,
            direction     : 0x1::string::utf8(b"out"),
            pool_balance  : 0x2::balance::value<T0>(&arg1.amount),
            coin_type     : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
        };
        0x2::event::emit<TransEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

