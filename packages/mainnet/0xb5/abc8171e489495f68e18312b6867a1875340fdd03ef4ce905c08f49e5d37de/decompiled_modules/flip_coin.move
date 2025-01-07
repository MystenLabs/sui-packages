module 0xb5abc8171e489495f68e18312b6867a1875340fdd03ef4ce905c08f49e5d37de::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(&arg2);
        let v1 = 0x2::balance::value<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(&arg0.val);
        if (v1 < v0) {
            abort 0
        };
        if (v1 < v0 * 10) {
            abort 1
        };
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = 0x2::tx_context::sender(arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v2)) {
            withdraw(arg0, v0, v3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>>(arg2, v3);
        } else {
            deposit(arg0, arg2, arg4);
        };
    }

    public entry fun public_deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit(arg0, arg1, arg2);
    }

    public entry fun public_withdraw(arg0: &AdaminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        withdraw(arg1, arg2, v0, arg3);
    }

    fun withdraw(arg0: &mut Game, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>>(0x2::coin::from_balance<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(0x2::balance::split<0x72b9943e22a65053ebbc1b20d4bb857e1c710f55e54069a5f9d1739d9eb44af::alwenxx_faucet_coin::ALWENXX_FAUCET_COIN>(&mut arg0.val, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

