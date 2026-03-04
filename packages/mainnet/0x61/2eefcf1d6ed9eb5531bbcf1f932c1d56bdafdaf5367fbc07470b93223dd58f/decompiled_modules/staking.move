module 0x612eefcf1d6ed9eb5531bbcf1f932c1d56bdafdaf5367fbc07470b93223dd58f::staking {
    struct Stake has key {
        id: 0x2::object::UID,
        amount: u64,
        reward_debt: u64,
        last_update: u64,
    }

    struct InterestPool has key {
        id: 0x2::object::UID,
        total_staked: u64,
        acc_reward_per_share: u128,
        last_reward_block: u64,
        balance: 0x2::balance::Balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
        treasury_cap: 0x2::coin::TreasuryCap<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>,
    }

    public fun claim(arg0: &mut InterestPool, arg1: &mut Stake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN> {
        update_pool(arg0, arg2);
        let v0 = ((arg0.acc_reward_per_share * (arg1.amount as u128) / 1000000000000) as u64) - arg1.reward_debt;
        arg1.reward_debt = arg1.reward_debt + v0;
        0x2::coin::mint<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.treasury_cap, v0, arg3)
    }

    public fun create_interest_pool(arg0: 0x2::coin::TreasuryCap<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg1: &mut 0x2::tx_context::TxContext) : InterestPool {
        InterestPool{
            id                   : 0x2::object::new(arg1),
            total_staked         : 0,
            acc_reward_per_share : 0,
            last_reward_block    : 0,
            balance              : 0x2::balance::zero<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(),
            treasury_cap         : arg0,
        }
    }

    public fun stake(arg0: &mut InterestPool, arg1: 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Stake {
        update_pool(arg0, arg2);
        let v0 = 0x2::coin::value<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&arg1);
        arg0.total_staked = arg0.total_staked + v0;
        0x2::balance::join<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.balance, 0x2::coin::into_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(arg1));
        Stake{
            id          : 0x2::object::new(arg3),
            amount      : v0,
            reward_debt : ((arg0.acc_reward_per_share * (v0 as u128) / 1000000000000) as u64),
            last_update : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun unstake(arg0: &mut InterestPool, arg1: &mut Stake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN> {
        update_pool(arg0, arg2);
        let v0 = ((arg0.acc_reward_per_share * (arg1.amount as u128) / 1000000000000) as u64) - arg1.reward_debt;
        arg0.total_staked = arg0.total_staked - arg1.amount;
        let v1 = 0x2::coin::from_balance<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(0x2::balance::split<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.balance, arg1.amount), arg3);
        if (v0 > 0) {
            0x2::coin::join<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut v1, 0x2::coin::mint<0xc35586b79bf73a38c98ac27e7da0f17dca85d98b7e92f9108763fe0024d31cd0::my_coin::MY_COIN>(&mut arg0.treasury_cap, v0, arg3));
        };
        v1
    }

    fun update_pool(arg0: &mut InterestPool, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.last_reward_block == 0) {
            arg0.last_reward_block = v0;
            return
        };
        if (arg0.total_staked == 0) {
            arg0.last_reward_block = v0;
            return
        };
        arg0.acc_reward_per_share = arg0.acc_reward_per_share + ((v0 - arg0.last_reward_block) as u128) * 1000000000000 / (arg0.total_staked as u128);
        arg0.last_reward_block = v0;
    }

    // decompiled from Move bytecode v6
}

