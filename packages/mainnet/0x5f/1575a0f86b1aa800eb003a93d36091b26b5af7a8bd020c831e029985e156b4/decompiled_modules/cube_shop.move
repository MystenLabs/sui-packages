module 0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube_shop {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Shop has key {
        id: 0x2::object::UID,
        price_per_cube: u64,
        cube_balance: 0x2::balance::Balance<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>,
        admin: address,
    }

    public fun buy_cubes(arg0: &mut Shop, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) / arg0.price_per_cube;
        assert!(v0 > 0, 1);
        assert!(0x2::balance::value<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>(&arg0.cube_balance) >= v0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>>(0x2::coin::take<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>(&mut arg0.cube_balance, v0, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, arg0.admin);
    }

    public fun deposit_cubes(arg0: &mut Shop, arg1: 0x2::coin::Coin<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>, arg2: &AdminCap) {
        0x2::coin::put<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>(&mut arg0.cube_balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Shop{
            id             : 0x2::object::new(arg0),
            price_per_cube : 50000,
            cube_balance   : 0x2::balance::zero<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>(),
            admin          : v0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, v0);
        0x2::transfer::share_object<Shop>(v1);
    }

    public fun update_price(arg0: &mut Shop, arg1: u64, arg2: &AdminCap) {
        assert!(arg1 > 0, 3);
        arg0.price_per_cube = arg1;
    }

    public fun withdraw_cubes(arg0: &mut Shop, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>>(0x2::coin::take<0x5f1575a0f86b1aa800eb003a93d36091b26b5af7a8bd020c831e029985e156b4::cube::CUBE>(&mut arg0.cube_balance, arg1, arg3), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

