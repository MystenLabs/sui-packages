module 0x7e1792a1a41a30206da3198784b9285dfa1e66bf227d834eb5d2ac9495554a64::flip_coin {
    struct Game has key {
        id: 0x2::object::UID,
        val: 0x2::balance::Balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_sui(arg0: &mut Game, arg1: 0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game{
            id  : 0x2::object::new(arg0),
            val : 0x2::balance::zero<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Game>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun play(arg0: &mut Game, arg1: bool, arg2: 0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::balance::value<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&arg0.val);
        if (v2 < v0) {
            abort 100
        };
        if (v0 > v2 / 10) {
            abort 101
        };
        let v3 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(0x2::coin::from_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(0x2::balance::split<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.val, v0), arg4), v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(arg2, v1);
        } else {
            0x2::balance::join<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg0.val, 0x2::coin::into_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(arg2));
        };
    }

    public entry fun remove_sui(arg0: &AdminCap, arg1: &mut Game, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>>(0x2::coin::from_balance<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(0x2::balance::split<0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin::M2887_FAUCET_COIN>(&mut arg1.val, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

