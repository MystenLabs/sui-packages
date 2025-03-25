module 0x39cf787242bf017003fdcaf9302bc90b9e8df653ee18130bb6413b35f6907ca5::task4 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GamePool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>,
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut GamePool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>>(0x2::coin::from_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::balance::withdraw_all<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg1.amount), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GamePool{
            id     : 0x2::object::new(arg0),
            amount : 0x2::balance::zero<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(),
        };
        0x2::transfer::share_object<GamePool>(v1);
    }

    public entry fun play(arg0: &mut 0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>, arg1: u64, arg2: &mut GamePool, arg3: bool, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 5000000000, 10);
        assert!(arg1 <= 0x2::balance::value<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&arg2.amount), 11);
        let v0 = 0x2::random::new_generator(arg4, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg3) {
            0x2::coin::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(arg0, 0x2::coin::from_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::balance::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg2.amount, arg1), arg5));
        } else {
            0x2::balance::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg2.amount, 0x2::coin::into_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::coin::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(arg0, arg1, arg5)));
        };
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut 0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>, arg2: u64, arg3: &mut GamePool, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg3.amount, 0x2::coin::into_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::coin::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(arg1, arg2, arg4)));
    }

    // decompiled from Move bytecode v6
}

