module 0x8447c507c103a33d324d483caaabb3a048ea8e37287593e3c51d274f6c87a81f::bright_flip {
    struct Game has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>,
        creator: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        creator: vector<u8>,
    }

    public entry fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg0.pool, 0x2::coin::into_balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id      : 0x2::object::new(arg0),
            pool    : 0x2::balance::zero<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(),
            creator : b"yueliao11",
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{
            id      : 0x2::object::new(arg0),
            creator : b"yueliao11",
        };
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&arg2);
        let v1 = 0x2::balance::value<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&arg0.pool);
        assert!(v1 >= v0, 0);
        assert!(v1 >= v0 * 10, 1);
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>>(arg2, v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>>(0x2::coin::from_balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(0x2::balance::split<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg0.pool, v0), arg4), v3);
        } else {
            0x2::balance::join<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg0.pool, 0x2::coin::into_balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(arg2));
        };
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>>(0x2::coin::from_balance<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(0x2::balance::split<0x4e4ca0ff3a45ec5a9f81abe87a2c87ca13c95b73a2007eeab1f1d92a5b704e5f::bright_faucet_coin::BRIGHT_FAUCET_COIN>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

