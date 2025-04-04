module 0x69f6ef8ea978d3ec95113948798d33f7a8710c5f604b0016c575b030f6d4f30b::game {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun Deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(0x2::coin::balance_mut<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(arg1), arg2));
    }

    public entry fun Play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: u8, arg3: &mut 0x2::coin::Coin<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(arg3) >= arg4, 1000);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_u8_in_range(&mut v0, 0, 2) == arg2) {
            0x2::coin::join<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(arg3, 0x2::coin::take<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg0.balance, arg4, arg5));
        } else {
            Deposit(arg0, arg3, arg4);
        };
    }

    public entry fun Withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>>(0x2::coin::take<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xe2e62fe87a81623765b98f279f1b794f3075b51ad21d346dc75126ccd3e468e::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

