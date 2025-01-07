module 0x378ff74d177fd298351feb3d0e2137d9e9fafa91f5ad809d0567419c9422cbe0::meme {
    struct MemCoinOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct State<phantom T0> has key {
        id: 0x2::object::UID,
        start: u64,
        end: u64,
        next_tick: u64,
        all_tickets: u64,
        won_tickets: u64,
        ticket_price: u64,
        tokens_per_ticket: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct UserState has store, key {
        id: 0x2::object::UID,
        won_tickets: u64,
        all_tickets: u64,
    }

    public entry fun buy<T0>(arg0: &mut State<T0>, arg1: &mut UserState, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg0.ticket_price, 3);
        assert!(v0 >= arg0.start, 1);
        assert!(v0 < arg0.end, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg0.ticket_price, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg2), arg0.ticket_price, arg4), @0xcf2d85465d72cef66b9e50161d1c2fbf3b0fef4d51434d4f88163f7d288f7685);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        if (v0 >= arg0.next_tick) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg0.tokens_per_ticket, arg4), 0x2::tx_context::sender(arg4));
            arg0.won_tickets = arg0.won_tickets + 1;
            arg1.won_tickets = arg1.won_tickets + 1;
            arg0.next_tick = arg0.next_tick + 250 + hash_to_u64(*0x2::tx_context::digest(arg4)) % 200;
        };
        arg0.all_tickets = arg0.all_tickets + 1;
        arg1.all_tickets = arg1.all_tickets + 1;
    }

    public entry fun create_state<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xcf2d85465d72cef66b9e50161d1c2fbf3b0fef4d51434d4f88163f7d288f7685, 4);
        let v0 = State<T0>{
            id                : 0x2::object::new(arg3),
            start             : arg1,
            end               : arg2,
            next_tick         : arg1,
            all_tickets       : 0,
            won_tickets       : 0,
            ticket_price      : 1000000000,
            tokens_per_ticket : 17500000000000,
            balance           : 0x2::balance::zero<T0>(),
        };
        0x2::coin::put<T0>(&mut v0.balance, arg0);
        0x2::transfer::share_object<State<T0>>(v0);
    }

    public entry fun create_user_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserState{
            id          : 0x2::object::new(arg0),
            won_tickets : 0,
            all_tickets : 0,
        };
        0x2::transfer::public_transfer<UserState>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun hash_to_u64(arg0: vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(&arg0) >= 8, 1);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0, (v1 as u64)) as u64) << v1 * 8);
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MemCoinOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MemCoinOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

