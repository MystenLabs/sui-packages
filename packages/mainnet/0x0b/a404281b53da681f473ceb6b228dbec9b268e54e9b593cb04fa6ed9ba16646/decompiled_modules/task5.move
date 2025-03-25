module 0xba404281b53da681f473ceb6b228dbec9b268e54e9b593cb04fa6ed9ba16646::task5 {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Swap has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>,
        faucet_coin: 0x2::balance::Balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>,
    }

    public entry fun get_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2 > 0 && 0x2::balance::value<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(&arg1.coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>>(0x2::coin::from_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(0x2::balance::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(&mut arg1.coin, arg2), arg4), 0x2::tx_context::sender(arg4));
        };
        if (arg3 > 0 && 0x2::balance::value<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&arg1.faucet_coin) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>>(0x2::coin::from_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::balance::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg1.faucet_coin, arg3), arg4), 0x2::tx_context::sender(arg4));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Swap{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(),
            faucet_coin : 0x2::balance::zero<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Swap>(v1);
    }

    public entry fun save_coin(arg0: &AdminCap, arg1: &mut Swap, arg2: &mut 0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>, arg3: u64, arg4: &mut 0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 0) {
            0x2::balance::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(&mut arg1.coin, 0x2::coin::into_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(0x2::coin::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(arg2, arg3, arg6)));
        };
        if (arg5 > 0) {
            0x2::balance::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg1.faucet_coin, 0x2::coin::into_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::coin::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(arg4, arg5, arg6)));
        };
    }

    public entry fun swap_coin_to_faucet(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 * 2;
        assert!(0x2::balance::value<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&arg0.faucet_coin) >= v0, 9223372264488042495);
        0x2::balance::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(&mut arg0.coin, 0x2::coin::into_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(0x2::coin::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>>(0x2::coin::from_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::balance::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg0.faucet_coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_faucet_to_coin(arg0: &mut Swap, arg1: &mut 0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 / 2;
        assert!(0x2::balance::value<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(&arg0.coin) >= v0, 9223372311732682751);
        0x2::balance::join<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(0x2::coin::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::faucet_lxjianbai::FAUCET_LXJIANBAI>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>>(0x2::coin::from_balance<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(0x2::balance::split<0xd7bbedd2bb65de04bf49525b9380212306f3627ae9afe8dbcf5c19babe8cba2b::lxjianbai::LXJIANBAI>(&mut arg0.coin, v0), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

