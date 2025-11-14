module 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::staking {
    struct Pool has store, key {
        id: 0x2::object::UID,
        rewards: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>,
        admin: address,
    }

    struct Position has store {
        shares: u64,
        reward_snap: u128,
    }

    struct PoolV2 has store, key {
        id: 0x2::object::UID,
        admin: address,
        staked: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>,
        rewards: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>,
        total_shares: u64,
        reward_index: u128,
        stakers: vector<address>,
        positions: vector<Position>,
    }

    fun add_rewards_v2(arg0: &mut PoolV2, arg1: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1);
            return
        };
        if (arg0.total_shares > 0) {
            arg0.reward_index = arg0.reward_index + (v0 as u128) * 1000000000 / (arg0.total_shares as u128);
        };
        0x2::coin::join<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.rewards, arg1);
    }

    public entry fun burn90_and_deposit10(arg0: &mut Pool, arg1: &mut 0x2::coin::TreasuryCap<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg2: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg2);
            return
        };
        0x2::coin::burn<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1, 0x2::coin::split<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg2, v0 * 9 / 10, arg3));
        0x2::coin::join<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.rewards, arg2);
    }

    public entry fun burn90_and_deposit10_v2(arg0: &mut PoolV2, arg1: &mut 0x2::coin::TreasuryCap<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg2: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg2);
            return
        };
        0x2::coin::burn<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1, 0x2::coin::split<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg2, v0 * 9 / 10, arg3));
        add_rewards_v2(arg0, arg2, arg3);
    }

    public entry fun claim_staking_rewards(arg0: &mut PoolV2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = find_index(&arg0.stakers, v0);
        assert!(v1, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOTHING_TO_CLAIM());
        pay_and_update_single_v2(arg0, v2, v0, arg1);
    }

    public fun create_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Pool {
        Pool{
            id      : 0x2::object::new(arg1),
            rewards : 0x2::coin::zero<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1),
            admin   : arg0,
        }
    }

    public entry fun create_pool_and_share(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool>(create_pool(arg0, arg1));
    }

    public fun create_pool_v2(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : PoolV2 {
        PoolV2{
            id           : 0x2::object::new(arg1),
            admin        : arg0,
            staked       : 0x2::coin::zero<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1),
            rewards      : 0x2::coin::zero<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(arg1),
            total_shares : 0,
            reward_index : 0,
            stakers      : 0x1::vector::empty<address>(),
            positions    : 0x1::vector::empty<Position>(),
        }
    }

    public entry fun create_pool_v2_and_share(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<PoolV2>(create_pool_v2(arg0, arg1));
    }

    public entry fun deposit_rewards(arg0: &mut Pool, arg1: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>) {
        0x2::coin::join<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.rewards, arg1);
    }

    public entry fun deposit_rewards_v2(arg0: &mut PoolV2, arg1: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        add_rewards_v2(arg0, arg1, arg2);
    }

    fun find_index(arg0: &vector<address>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun pay_and_update_single_v2(arg0: &mut PoolV2, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, arg1);
        let v1 = v0.shares;
        let v2 = v0.reward_snap;
        let v3 = arg0.reward_index;
        if (v1 == 0) {
            v0.reward_snap = v3;
            return
        };
        if (v3 <= v2) {
            v0.reward_snap = v3;
            return
        };
        let v4 = (((v3 - v2) * (v1 as u128) / 1000000000) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>>(0x2::coin::split<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.rewards, v4, arg3), arg2);
        };
        v0.reward_snap = v3;
    }

    public entry fun stake(arg0: &mut PoolV2, arg1: 0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&arg1);
        assert!(v1 > 0, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOTHING_TO_CLAIM());
        let (v2, v3) = find_index(&arg0.stakers, v0);
        if (v2) {
            pay_and_update_single_v2(arg0, v3, v0, arg2);
            let v4 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v3);
            v4.shares = v4.shares + v1;
        } else {
            0x1::vector::push_back<address>(&mut arg0.stakers, v0);
            let v5 = Position{
                shares      : v1,
                reward_snap : arg0.reward_index,
            };
            0x1::vector::push_back<Position>(&mut arg0.positions, v5);
        };
        arg0.total_shares = arg0.total_shares + v1;
        0x2::coin::join<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.staked, arg1);
    }

    public entry fun sweep_all(arg0: &mut Pool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == arg0.admin, 777);
        let v0 = 0x2::coin::value<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&arg0.rewards);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>>(0x2::coin::split<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.rewards, v0, arg2), arg1);
        };
    }

    public entry fun sweep_all_v2(arg0: &mut PoolV2, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == arg0.admin, 777);
        let v0 = 0x2::coin::value<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&arg0.rewards);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>>(0x2::coin::split<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.rewards, v0, arg2), arg1);
        };
    }

    public entry fun unstake(arg0: &mut PoolV2, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 > 0, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOTHING_TO_CLAIM());
        let (v1, v2) = find_index(&arg0.stakers, v0);
        assert!(v1, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOTHING_TO_CLAIM());
        pay_and_update_single_v2(arg0, v2, v0, arg2);
        let v3 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v2);
        assert!(v3.shares >= arg1, 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::errors::E_NOTHING_TO_CLAIM());
        v3.shares = v3.shares - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>>(0x2::coin::split<0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::faith::FAITH>(&mut arg0.staked, arg1, arg2), v0);
        v3.reward_snap = arg0.reward_index;
    }

    // decompiled from Move bytecode v6
}

