module 0xa42426f6efe44d433240afab9373d311ca8aa5159a41f1fe490e8b77881c2231::game {
    struct GamePool has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_game_pool(arg0: &mut GamePool, arg1: 0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg0.pool, 0x2::coin::into_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(arg1));
    }

    public entry fun get_game_pool(arg0: &AdminCap, arg1: &mut GamePool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>>(0x2::coin::from_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(0x2::balance::split<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GamePool{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GamePool>(v1);
    }

    public entry fun play(arg0: &mut GamePool, arg1: bool, arg2: 0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&arg2);
        assert!(v0 <= 5000000000, 4097);
        assert!(v0 <= 0x2::balance::value<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&arg0.pool), 4098);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        if (arg1 == 0x2::random::generate_bool(&mut v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>>(0x2::coin::from_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(0x2::balance::split<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg0.pool, 0x2::coin::value<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&arg2)), arg4), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::join<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(&mut arg0.pool, 0x2::coin::into_balance<0x2ba9a31fbd3e1ef640c0c52fd4f0a719ba881514133fcd5884b48b62c0eb58d2::xdd_object_faucet::XDD_OBJECT_FAUCET>(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

