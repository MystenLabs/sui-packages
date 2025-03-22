module 0xb5b71b776a14601c58e17a246efe02ce4546b9f8980c89b39ad3c5fe1a43f5b0::lifejwang11 {
    struct SwapPool has key {
        id: 0x2::object::UID,
        coin: 0x2::balance::Balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>,
        faucet_coin: 0x2::balance::Balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin_to_pool(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(&mut arg0.coin, 0x2::coin::into_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(0x2::coin::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(arg1, arg2, arg3)));
    }

    public entry fun add_faucet_to_pool(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(0x2::coin::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(arg1, arg2, arg3)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapPool{
            id          : 0x2::object::new(arg0),
            coin        : 0x2::balance::zero<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(),
            faucet_coin : 0x2::balance::zero<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(),
        };
        0x2::transfer::share_object<SwapPool>(v0);
        let v1 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_to_coin(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(arg1) >= arg2, 1);
        assert!(0x2::balance::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(&arg0.coin) >= arg2, 0);
        0x2::balance::join<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, 0x2::coin::into_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(0x2::coin::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>>(0x2::coin::from_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(0x2::balance::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(&mut arg0.coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_to_faucet(arg0: &mut SwapPool, arg1: &mut 0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(arg1) >= arg2, 1);
        assert!(0x2::balance::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&arg0.faucet_coin) >= arg2, 0);
        0x2::balance::join<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(&mut arg0.coin, 0x2::coin::into_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(0x2::coin::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg0.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_coin_from_pool(arg0: &Admin, arg1: &mut SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(&arg1.coin) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>>(0x2::coin::from_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(0x2::balance::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::my_coin::MY_COIN>(&mut arg1.coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_faucet_from_pool(arg0: &Admin, arg1: &mut SwapPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&arg1.faucet_coin) >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>>(0x2::coin::from_balance<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(0x2::balance::split<0x5bfc7604744180b2555ad6031bd3a381441a5aaad883ea7618ca200dd4a462f6::faucet_coin::FAUCET_COIN>(&mut arg1.faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

