module 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::interface {
    public entry fun get_rewards<T0>(arg0: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::AccountStorage, arg2: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPXStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPX>>(0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::get_rewards<T0>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun stake<T0>(arg0: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::AccountStorage, arg2: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPXStorage, arg3: &0x2::clock::Clock, arg4: vector<0x2::coin::Coin<T0>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPX>>(0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::stake<T0>(arg0, arg1, arg2, arg3, 0xbd8d525f659483420b2da568b924c63973240b2ddfd148e3909e17c43d189764::utils::handle_coin_vector<T0>(arg4, arg5, arg6), arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun unstake<T0>(arg0: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::AccountStorage, arg2: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPXStorage, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2) = 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::unstake<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::aipx::AIPX>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
    }

    public entry fun update_all_pools(arg0: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &0x2::clock::Clock) {
        0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::update_all_pools(arg0, arg1);
    }

    public entry fun update_pool<T0>(arg0: &mut 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &0x2::clock::Clock) {
        0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::update_pool<T0>(arg0, arg1);
    }

    fun get_farm<T0>(arg0: &0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::AccountStorage, arg2: address, arg3: &mut vector<vector<u64>>) {
        let v0 = 0x1::vector::empty<u64>();
        let (v1, _, _, v4) = 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::get_pool_info<T0>(arg0);
        0x1::vector::push_back<u64>(&mut v0, v1);
        0x1::vector::push_back<u64>(&mut v0, v4);
        if (0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::account_exists<T0>(arg0, arg1, arg2)) {
            let (v5, _) = 0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::get_account_info<T0>(arg0, arg1, arg2);
            0x1::vector::push_back<u64>(&mut v0, v5);
        } else {
            0x1::vector::push_back<u64>(&mut v0, 0);
        };
        0x1::vector::push_back<vector<u64>>(arg3, v0);
    }

    public fun get_farms<T0, T1, T2>(arg0: &0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::MasterChefStorage, arg1: &0xdd337a572de87a228cf4f7b5b7cb30313cad7506ac5cea396258e22e67c6179f::amaster_chef::AccountStorage, arg2: address, arg3: u64) : vector<vector<u64>> {
        let v0 = 0x1::vector::empty<vector<u64>>();
        let v1 = &mut v0;
        get_farm<T0>(arg0, arg1, arg2, v1);
        if (arg3 == 1) {
            return v0
        };
        let v2 = &mut v0;
        get_farm<T1>(arg0, arg1, arg2, v2);
        if (arg3 == 2) {
            return v0
        };
        let v3 = &mut v0;
        get_farm<T2>(arg0, arg1, arg2, v3);
        v0
    }

    // decompiled from Move bytecode v6
}

