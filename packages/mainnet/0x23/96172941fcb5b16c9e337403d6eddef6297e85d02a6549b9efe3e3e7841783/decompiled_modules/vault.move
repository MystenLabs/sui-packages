module 0x2396172941fcb5b16c9e337403d6eddef6297e85d02a6549b9efe3e3e7841783::vault {
    struct Leaderboard<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        reward: 0x2::balance::Balance<T0>,
        claimed_reward_amount: u64,
        max_leaderboard_size: u64,
        top_vaults: vector<0x2::object::ID>,
        top_balances: vector<u64>,
        end_timestamp_ms: u64,
    }

    struct VaultManager has store, key {
        id: 0x2::object::UID,
        vaults: 0x2::bag::Bag,
    }

    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        leaderboard_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct VaultOwnerCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun check_out_vault<T0>(arg0: &mut VaultManager, arg1: &Leaderboard<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::borrow_mut<0x2::object::ID, Vault<T0>>(&mut arg0.vaults, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, 0x2::balance::value<T0>(&v0.balance)), arg3), arg1.creator);
    }

    public fun create_leaderboard<T0>(arg0: u64, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard<T0>{
            id                    : 0x2::object::new(arg2),
            creator               : 0x2::tx_context::sender(arg2),
            reward                : 0x2::coin::into_balance<T0>(arg1),
            claimed_reward_amount : 0,
            max_leaderboard_size  : 30,
            top_vaults            : 0x1::vector::empty<0x2::object::ID>(),
            top_balances          : 0x1::vector::empty<u64>(),
            end_timestamp_ms      : arg0,
        };
        0x2::transfer::share_object<Leaderboard<T0>>(v0);
    }

    public fun create_vault<T0>(arg0: &mut VaultManager, arg1: &mut Leaderboard<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : VaultOwnerCap<T0> {
        let v0 = Vault<T0>{
            id             : 0x2::object::new(arg3),
            leaderboard_id : 0x2::object::id<Leaderboard<T0>>(arg1),
            balance        : 0x2::coin::into_balance<T0>(arg2),
        };
        let v1 = 0x2::object::id<Vault<T0>>(&v0);
        0x2::bag::add<0x2::object::ID, Vault<T0>>(&mut arg0.vaults, v1, v0);
        update_leaderboard<T0>(arg1, v1, 0x2::balance::value<T0>(&v0.balance));
        VaultOwnerCap<T0>{
            id       : 0x2::object::new(arg3),
            vault_id : v1,
        }
    }

    public fun deposit_reward<T0>(arg0: &mut Leaderboard<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 1);
        0x2::balance::join<T0>(&mut arg0.reward, 0x2::coin::into_balance<T0>(arg1));
        update_end_timestamp<T0>(arg0, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultManager{
            id     : 0x2::object::new(arg0),
            vaults : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<VaultManager>(v0);
    }

    public fun update_end_timestamp<T0>(arg0: &mut Leaderboard<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 1);
        arg0.end_timestamp_ms = arg1;
    }

    fun update_leaderboard<T0>(arg0: &mut Leaderboard<T0>, arg1: 0x2::object::ID, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.top_vaults, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.top_vaults, v1);
            0x1::vector::remove<u64>(&mut arg0.top_balances, v1);
        };
        let v2 = 0x1::vector::length<u64>(&arg0.top_balances) - 1;
        let v3 = v2;
        if (arg2 < *0x1::vector::borrow<u64>(&arg0.top_balances, v2) && 0x1::vector::length<u64>(&arg0.top_balances) < arg0.max_leaderboard_size) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.top_vaults, arg1);
            0x1::vector::push_back<u64>(&mut arg0.top_balances, arg2);
        } else if (arg2 > *0x1::vector::borrow<u64>(&arg0.top_balances, v2)) {
            loop {
                if (arg2 > *0x1::vector::borrow<u64>(&arg0.top_balances, v3)) {
                    break
                };
                let v4 = v3 - 1;
                v3 = v4;
                if (v4 == 0) {
                    break
                };
            };
            0x1::vector::insert<0x2::object::ID>(&mut arg0.top_vaults, arg1, v3);
            0x1::vector::insert<u64>(&mut arg0.top_balances, arg2, v3);
            if (0x1::vector::length<u64>(&arg0.top_balances) >= arg0.max_leaderboard_size) {
                0x1::vector::pop_back<0x2::object::ID>(&mut arg0.top_vaults);
                0x1::vector::pop_back<u64>(&mut arg0.top_balances);
            };
        };
    }

    public fun vote<T0>(arg0: &mut VaultManager, arg1: &mut Leaderboard<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::bag::borrow_mut<0x2::object::ID, Vault<T0>>(&mut arg0.vaults, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) < arg1.end_timestamp_ms, 1);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg3));
        update_leaderboard<T0>(arg1, 0x2::object::id<Vault<T0>>(v0), 0x2::balance::value<T0>(&v0.balance));
    }

    public fun withdraw<T0>(arg0: &mut VaultManager, arg1: &VaultOwnerCap<T0>, arg2: &mut Leaderboard<T0>, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::remove<0x2::object::ID, Vault<T0>>(&mut arg0.vaults, arg3);
        assert!(0x2::clock::timestamp_ms(arg4) > arg2.end_timestamp_ms && 0x2::object::id<Leaderboard<T0>>(arg2) == v0.leaderboard_id, 1);
        let Vault {
            id             : v1,
            leaderboard_id : _,
            balance        : v3,
        } = v0;
        let v4 = v3;
        0x2::object::delete(v1);
        let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(&arg2.top_vaults, &arg3);
        if (v5) {
            0x1::vector::remove<0x2::object::ID>(&mut arg2.top_vaults, v6);
            0x1::vector::remove<u64>(&mut arg2.top_balances, v6);
            arg2.claimed_reward_amount = arg2.claimed_reward_amount + 1;
            0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg2.reward, 0x2::balance::value<T0>(&arg2.reward) / (30 - arg2.claimed_reward_amount)));
        };
        0x2::coin::from_balance<T0>(v4, arg5)
    }

    public fun withdraw_reward<T0>(arg0: &mut Leaderboard<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

