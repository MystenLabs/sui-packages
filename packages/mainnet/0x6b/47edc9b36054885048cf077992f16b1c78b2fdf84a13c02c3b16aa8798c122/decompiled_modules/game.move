module 0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::game {
    struct GAME has key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        balance: 0x2::balance::Balance<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>,
        provider: 0x2::linked_table::LinkedTable<address, u64>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_pool(arg0: &mut GAME, arg1: 0x2::coin::Coin<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::linked_table::contains<address, u64>(&mut arg0.provider, v0)) {
            0x2::linked_table::push_back<address, u64>(&mut arg0.provider, v0, 0);
        };
        let v1 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.provider, v0);
        *v1 = *v1 + 0x2::coin::value<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&arg1);
        0x2::balance::join<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(arg1));
    }

    public fun game_rule(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        if (0x2::random::generate_u8_in_range(&mut v0, 1, 4) == 1) {
            return true
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GAME{
            id       : 0x2::object::new(arg0),
            name     : 0x1::ascii::string(b"looikaizhi"),
            balance  : 0x2::balance::zero<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(),
            provider : 0x2::linked_table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<GAME>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut GAME, arg1: 0x2::coin::Coin<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&arg1);
        assert!(v0 <= 0x2::balance::value<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&arg0.balance) / 10, 9223372277372944383);
        let v1 = game_rule(arg2, arg3);
        if (v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>>(0x2::coin::from_balance<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(0x2::balance::split<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&mut arg0.balance, v0), arg3), 0x2::tx_context::sender(arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>>(arg1, 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&mut arg0.balance, 0x2::coin::into_balance<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(arg1));
        };
        provider_result(arg0, v0, !v1);
    }

    public fun provider_result(arg0: &mut GAME, arg1: u64, arg2: bool) {
        let v0 = 0x2::balance::value<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&arg0.balance);
        assert!(v0 > 0, 9223372509301178367);
        let v1 = *0x2::linked_table::front<address, u64>(&mut arg0.provider);
        while (0x1::option::is_some<address>(&mut v1)) {
            let v2 = 0x1::option::extract<address>(&mut v1);
            let v3 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.provider, v2);
            if (arg2) {
                *v3 = *v3 + *v3 * arg1 / v0;
            } else {
                *v3 = *v3 - *v3 * arg1 / v0;
            };
            v1 = *0x2::linked_table::next<address, u64>(&mut arg0.provider, v2);
        };
    }

    public entry fun withdraw_pool(arg0: &mut GAME, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::linked_table::contains<address, u64>(&arg0.provider, v0), 9223372453466603519);
        let v1 = 0x2::linked_table::borrow_mut<address, u64>(&mut arg0.provider, v0);
        assert!(*v1 >= arg1, 9223372462056538111);
        *v1 = *v1 - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>>(0x2::coin::from_balance<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(0x2::balance::split<0x6b47edc9b36054885048cf077992f16b1c78b2fdf84a13c02c3b16aa8798c122::gameFaucet::GAMEFAUCET>(&mut arg0.balance, arg1), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

