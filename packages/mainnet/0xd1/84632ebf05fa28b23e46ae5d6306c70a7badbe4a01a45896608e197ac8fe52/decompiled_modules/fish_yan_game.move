module 0xd184632ebf05fa28b23e46ae5d6306c70a7badbe4a01a45896608e197ac8fe52::fish_yan_game {
    struct FishYanGame has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun deposit(arg0: &mut FishYanGame, arg1: 0x2::coin::Coin<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&mut arg0.pool, 0x2::coin::into_balance<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FishYanGame{
            id   : 0x2::object::new(arg0),
            pool : 0x2::balance::zero<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(),
        };
        0x2::transfer::share_object<FishYanGame>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun play(arg0: &mut FishYanGame, arg1: 0x2::coin::Coin<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&arg1) == 1000000000, 0);
        deposit(arg0, arg1, arg3);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = if (0x2::random::generate_u8_in_range(&mut v0, 0, 5) < 3) {
            0
        } else {
            2000000000
        };
        let v2 = 0x2::tx_context::sender(arg3);
        withdraw(arg0, v1, v2, arg3);
    }

    public entry fun withdraw(arg0: &mut FishYanGame, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>>(0x2::coin::from_balance<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(0x2::balance::split<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&mut arg0.pool, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

