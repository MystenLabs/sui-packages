module 0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::staking {
    struct Position has store {
        shares: u64,
        reward_snap: u128,
        entered_epoch: u64,
    }

    struct BuybackFaithApplied has copy, drop {
        total: u64,
        burned: u64,
        rewards: u64,
    }

    struct StakingPool has store, key {
        id: 0x2::object::UID,
        admin: address,
        staked: 0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>,
        rewards: 0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>,
        total_shares: u64,
        reward_index: u128,
        stakers: vector<address>,
        positions: vector<Position>,
    }

    fun add_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&arg1);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(arg1);
            return
        };
        if (arg0.total_shares > 0) {
            arg0.reward_index = arg0.reward_index + (v0 as u128) * 1000000000 / (arg0.total_shares as u128);
        };
        0x2::coin::join<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&mut arg0.rewards, arg1);
    }

    fun blessings_multiplier_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 <= arg0) {
            10000
        } else {
            let v1 = (arg1 - arg0) * 150;
            let v2 = 15000;
            let v3 = if (v1 > v2) {
                v2
            } else {
                v1
            };
            10000 + v3
        }
    }

    public entry fun burn90_and_deposit10(arg0: &mut StakingPool, arg1: &mut 0x2::coin::TreasuryCap<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>, arg2: 0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&arg2);
        if (v0 == 0) {
            0x2::coin::destroy_zero<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(arg2);
            return
        };
        let v1 = v0 * 9 / 10;
        0x2::coin::burn<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(arg1, 0x2::coin::split<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&mut arg2, v1, arg3));
        add_rewards(arg0, arg2, arg3);
        let v2 = BuybackFaithApplied{
            total   : v0,
            burned  : v1,
            rewards : 0x2::coin::value<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&arg2),
        };
        0x2::event::emit<BuybackFaithApplied>(v2);
    }

    public entry fun claim_staking_rewards(arg0: &mut StakingPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = find_index(&arg0.stakers, v0);
        assert!(v1, 0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::errors::E_NOTHING_TO_CLAIM());
        pay_and_update_single(arg0, v2, v0, arg1);
    }

    public fun create_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : StakingPool {
        StakingPool{
            id           : 0x2::object::new(arg1),
            admin        : arg0,
            staked       : 0x2::coin::zero<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(arg1),
            rewards      : 0x2::coin::zero<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(arg1),
            total_shares : 0,
            reward_index : 0,
            stakers      : 0x1::vector::empty<address>(),
            positions    : 0x1::vector::empty<Position>(),
        }
    }

    public entry fun create_pool_and_share(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<StakingPool>(create_pool(arg0, arg1));
    }

    public entry fun deposit_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        add_rewards(arg0, arg1, arg2);
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

    fun pay_and_update_single(arg0: &mut StakingPool, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
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
        let v4 = (((v3 - v2) * (v1 as u128) * (blessings_multiplier_bps(v0.entered_epoch, 0x2::tx_context::epoch(arg3)) as u128) / 10000 / 1000000000) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>>(0x2::coin::split<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&mut arg0.rewards, v4, arg3), arg2);
        };
        v0.reward_snap = v3;
    }

    public entry fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = 0x2::coin::value<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&arg1);
        assert!(v2 > 0, 0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::errors::E_NOTHING_TO_CLAIM());
        let (v3, v4) = find_index(&arg0.stakers, v0);
        if (v3) {
            pay_and_update_single(arg0, v4, v0, arg2);
            let v5 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v4);
            v5.shares = v5.shares + v2;
            if (v5.entered_epoch == 0) {
                v5.entered_epoch = v1;
            };
        } else {
            0x1::vector::push_back<address>(&mut arg0.stakers, v0);
            let v6 = Position{
                shares        : v2,
                reward_snap   : arg0.reward_index,
                entered_epoch : v1,
            };
            0x1::vector::push_back<Position>(&mut arg0.positions, v6);
        };
        arg0.total_shares = arg0.total_shares + v2;
        0x2::coin::join<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&mut arg0.staked, arg1);
    }

    public entry fun sweep_all(arg0: &mut StakingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 777);
        assert!(arg1 == arg0.admin, 777);
        let v0 = 0x2::coin::value<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&arg0.rewards);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>>(0x2::coin::split<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&mut arg0.rewards, v0, arg2), arg1);
        };
    }

    public entry fun unstake(arg0: &mut StakingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1 > 0, 0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::errors::E_NOTHING_TO_CLAIM());
        let (v1, v2) = find_index(&arg0.stakers, v0);
        assert!(v1, 0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::errors::E_NOTHING_TO_CLAIM());
        pay_and_update_single(arg0, v2, v0, arg2);
        let v3 = 0x1::vector::borrow_mut<Position>(&mut arg0.positions, v2);
        assert!(v3.shares >= arg1, 0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::errors::E_NOTHING_TO_CLAIM());
        v3.shares = v3.shares - arg1;
        arg0.total_shares = arg0.total_shares - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>>(0x2::coin::split<0x12bc564f55674f8b150058397b9ad40a8954b90ef5ccf509c8577404f925ae57::faith::FAITH>(&mut arg0.staked, arg1, arg2), v0);
        v3.reward_snap = arg0.reward_index;
        if ((arg1 as u128) * 100 >= (v3.shares as u128) * 69) {
            v3.entered_epoch = 0;
        };
    }

    // decompiled from Move bytecode v6
}

