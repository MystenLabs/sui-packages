module 0xc87e8ea75d7c36535c86ab7a5b275b2c9cc195a3603c85eab5b48a3f453ea158::roll_the_dice {
    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        amt: 0x2::balance::Balance<T0>,
    }

    struct GameAdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_game_coin(arg0: &mut Game<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>, arg1: 0x2::coin::Coin<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(&mut arg0.amt, 0x2::coin::into_balance<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GameAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Game<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>{
            id  : 0x2::object::new(arg0),
            amt : 0x2::balance::zero<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(),
        };
        0x2::transfer::share_object<Game<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>>(v1);
    }

    entry fun play(arg0: &mut Game<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(&arg2);
        assert!(0x2::balance::value<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(&arg0.amt) >= v0 * 10, 1);
        let v1 = 0x2::random::new_generator(arg1, arg3);
        if (0x2::random::generate_u8_in_range(&mut v1, 1, 6) >= 4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>>(0x2::coin::from_balance<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(0x2::balance::split<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(&mut arg0.amt, v0 * 5 / 10), arg3), 0x2::tx_context::sender(arg3));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>>(arg2, 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(&mut arg0.amt, 0x2::coin::into_balance<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(arg2));
        };
    }

    public entry fun remove_game_coin(arg0: &GameAdminCap, arg1: &mut Game<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>>(0x2::coin::from_balance<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(0x2::balance::split<0x7952b17ed79ad43f3f2e23176ed60a0a3e3ccb78ff8324e231a887a45b048b97::zeros_faucet::ZEROS_FAUCET>(&mut arg1.amt, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

