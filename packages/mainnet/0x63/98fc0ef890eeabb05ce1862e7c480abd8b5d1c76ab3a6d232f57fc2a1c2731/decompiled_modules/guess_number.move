module 0x6398fc0ef890eeabb05ce1862e7c480abd8b5d1c76ab3a6d232f57fc2a1c2731::guess_number {
    struct GuessGameResult has copy, drop {
        you_number: u64,
        game_number: u64,
        output: 0x1::string::String,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun createPool<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public entry fun depoist<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun play<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Pool<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0 && arg2 < 10, 1);
        let v0 = random(arg3);
        let v1 = if (v0 == arg2) {
            let v2 = 0x2::coin::take<T0>(&mut arg1.balance, 1000000, arg4);
            0x2::coin::join<T0>(&mut v2, arg0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg4));
            0x1::string::utf8(b"You Win!")
        } else {
            0x2::coin::put<T0>(&mut arg1.balance, arg0);
            0x1::string::utf8(b"You Lose!")
        };
        let v3 = GuessGameResult{
            you_number  : arg2,
            game_number : v0,
            output      : v1,
        };
        0x2::event::emit<GuessGameResult>(v3);
    }

    fun random(arg0: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::hash::sha3_256(b"fengnian9527");
        let v1 = ((0x2::clock::timestamp_ms(arg0) * (0x1::vector::pop_back<u8>(&mut v0) as u64) % 10) as u64);
        0x1::debug::print<u64>(&v1);
        v1
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<AdminCap>(arg0) == 0x2::tx_context::sender(arg2), 3);
        let Pool {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

