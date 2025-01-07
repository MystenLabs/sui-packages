module 0x89b116488674b343d58ccdaad30904f9eb11bcef3628a3183652c589eecf7070::jamie_jan_guess_coin {
    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun AdminWithdraw(arg0: &AdminCap, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(&arg1.balance) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun Deposit(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::coin::Coin<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>) {
        assert!(0x2::coin::value<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(arg2) >= arg1, 1);
        0x2::balance::join<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(0x2::coin::balance_mut<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(arg2), arg1));
    }

    entry fun GamePlay(arg0: &0x2::random::Random, arg1: &mut Vault, arg2: bool, arg3: &mut 0x2::coin::Coin<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(arg3);
        assert!(0x2::balance::value<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(&arg1.balance) >= v0, 1);
        let v1 = 0x2::random::new_generator(arg0, arg4);
        if (0x2::random::generate_bool(&mut v1) == arg2) {
            0x2::coin::join<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(arg3, 0x2::coin::from_balance<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(&mut arg1.balance, v0), arg4));
        } else {
            let v2 = 0x2::coin::value<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(arg3);
            Deposit(arg1, v2, arg3);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x458446d261dff12681934d1a0f890fc341a522794007400279cce10ec16002e3::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

