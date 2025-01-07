module 0xe8451445cbeac5de8de145bcca7cd60b475e56884dc8c454c95b2fa6dddceb86::game {
    struct Rands has key {
        id: 0x2::object::UID,
        owner: address,
        worlds: vector<u8>,
        hp: u8,
        items: vector<u8>,
        turn_begin: vector<u8>,
        turn_item: vector<u8>,
        ai_random: u8,
        player_random: u8,
    }

    fun choice<T0: copy>(arg0: &vector<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        if (0x1::vector::is_empty<T0>(arg0)) {
            abort 0
        };
        let v0 = 0x2::random::new_generator(arg1, arg2);
        *0x1::vector::borrow<T0>(arg0, 0x2::random::generate_u64_in_range(&mut v0, 0, (0x1::vector::length<T0>(arg0) as u64) - 1))
    }

    fun choices<T0: copy>(arg0: &vector<T0>, arg1: u64, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : vector<T0> {
        if (0x1::vector::is_empty<T0>(arg0)) {
            abort 0
        };
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = 0x1::vector::empty<T0>();
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<T0>(&mut v1, *0x1::vector::borrow<T0>(arg0, 0x2::random::generate_u64_in_range(&mut v0, 0, (0x1::vector::length<T0>(arg0) as u64) - 1)));
            v2 = v2 + 1;
        };
        v1
    }

    entry fun rollDice(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = x"010203040506";
        let v1 = x"0102030405060708";
        let v2 = x"0001";
        let v3 = x"020304";
        let v4 = x"0102030405";
        let v5 = choice<u8>(&v1, arg0, arg1);
        let v6 = choices<u8>(&v2, (v5 as u64), arg0, arg1);
        let v7 = choice<u8>(&v3, arg0, arg1);
        let v8 = choices<u8>(&v4, 8, arg0, arg1);
        let v9 = choices<u8>(&v0, 2, arg0, arg1);
        let v10 = choices<u8>(&v0, 2, arg0, arg1);
        let v11 = 0x2::random::new_generator(arg0, arg1);
        let v12 = Rands{
            id            : 0x2::object::new(arg1),
            owner         : 0x2::tx_context::sender(arg1),
            worlds        : v6,
            hp            : v7,
            items         : v8,
            turn_begin    : v9,
            turn_item     : v10,
            ai_random     : 0x2::random::generate_u8(&mut v11),
            player_random : 0x2::random::generate_u8(&mut v11),
        };
        0x2::transfer::share_object<Rands>(v12);
    }

    // decompiled from Move bytecode v6
}

