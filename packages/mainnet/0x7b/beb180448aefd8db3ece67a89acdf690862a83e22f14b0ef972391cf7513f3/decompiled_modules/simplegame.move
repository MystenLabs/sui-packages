module 0x7bbeb180448aefd8db3ece67a89acdf690862a83e22f14b0ef972391cf7513f3::simplegame {
    struct Game has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>,
        game_name: vector<u8>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun Play(arg0: &mut Game, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(arg3) >= arg4, 1000);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(arg3, 0x2::coin::take<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(&mut arg0.balance, arg4, arg5));
        } else {
            deposit(arg0, arg3, arg4, arg5);
        };
    }

    public entry fun deposit(arg0: &mut Game, arg1: &mut 0x2::coin::Coin<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(arg1) >= arg2, 1000);
        0x2::balance::join<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(&mut arg0.balance, 0x2::balance::split<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(0x2::coin::balance_mut<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(),
            game_name : b"GRACECAMP GAME",
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw(arg0: &mut Game, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>>(0x2::coin::take<0x86d75073468e16543716d8bce3c23c7f7679198823278326bc060d8ee4acf37a::singmin_faucet::SINGMIN_FAUCET>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

