module 0x9377f240474976e577d32ea7f36bb8add6b50a5206e66baf292434872911d13e::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>,
    }

    struct AdaminCap has key {
        id: 0x2::object::UID,
    }

    fun deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdaminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdaminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(&arg2);
        let v1 = 0x2::balance::value<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(&arg0.val);
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
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>>(arg2, v3);
        } else {
            deposit(arg0, arg2, arg4);
        };
    }

    public entry fun public_deposit(arg0: &mut Game, arg1: 0x2::coin::Coin<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit(arg0, arg1, arg2);
    }

    public entry fun public_withdraw(arg0: &AdaminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        withdraw(arg1, arg2, v0, arg3);
    }

    fun withdraw(arg0: &mut Game, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>>(0x2::coin::from_balance<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(0x2::balance::split<0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin::VINGTEHAN_FAUCET_COIN>(&mut arg0.val, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

