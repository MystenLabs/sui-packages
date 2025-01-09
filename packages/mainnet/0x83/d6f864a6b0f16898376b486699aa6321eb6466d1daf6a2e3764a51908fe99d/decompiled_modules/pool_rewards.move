module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards {
    struct PoolRewards<phantom T0> has store {
        acc_reward_per_share_p: u128,
        admin_fee_share_bp: u64,
        admin_fee: 0x2::balance::Balance<T0>,
        rewards: 0x2::balance::Balance<T0>,
        lp_supply: u64,
    }

    public(friend) fun add_rewards<T0>(arg0: &mut PoolRewards<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg0.lp_supply as u128);
        if (v0 > 0) {
            0x2::coin::put<T0>(&mut arg0.admin_fee, 0x2::coin::split<T0>(&mut arg1, 0x2::coin::value<T0>(&arg1) * arg0.admin_fee_share_bp / 10000, arg2));
            arg0.acc_reward_per_share_p = arg0.acc_reward_per_share_p + ((0x2::coin::value<T0>(&arg1) as u128) << 48) / v0;
        };
        0x2::coin::put<T0>(&mut arg0.rewards, arg1);
    }

    public(friend) fun claim_admin_fee<T0>(arg0: &mut PoolRewards<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.admin_fee);
        if (v0 == 0) {
            return 0x2::coin::zero<T0>(arg1)
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.admin_fee, v0), arg1)
    }

    public(friend) fun claim_reward<T0>(arg0: &mut PoolRewards<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::lp_amount<T0>(arg1) == 0) {
            return 0x2::coin::zero<T0>(arg2)
        };
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::update_reward_debt<T0>(arg1, arg0.acc_reward_per_share_p);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, pending_rewards<T0>(arg0, arg1)), arg2)
    }

    public(friend) fun deposit_lp<T0>(arg0: &mut PoolRewards<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0.lp_supply = arg0.lp_supply + arg2;
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::add<T0>(arg1, arg2, arg0.acc_reward_per_share_p);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, pending_rewards<T0>(arg0, arg1)), arg3)
    }

    public(friend) fun get_admin_fee_share_bp<T0>(arg0: &PoolRewards<T0>) : u64 {
        arg0.admin_fee_share_bp
    }

    public(friend) fun lp_supply<T0>(arg0: &PoolRewards<T0>) : u64 {
        arg0.lp_supply
    }

    public(friend) fun new<T0>() : PoolRewards<T0> {
        PoolRewards<T0>{
            acc_reward_per_share_p : 0,
            admin_fee_share_bp     : 0,
            admin_fee              : 0x2::balance::zero<T0>(),
            rewards                : 0x2::balance::zero<T0>(),
            lp_supply              : 0,
        }
    }

    public(friend) fun pending_rewards<T0>(arg0: &PoolRewards<T0>, arg1: &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>) : u64 {
        let v0 = (0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::lp_amount<T0>(arg1) as u128);
        if (v0 == 0) {
            return 0
        };
        ((v0 * arg0.acc_reward_per_share_p >> 48) as u64) - 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::reward_debt<T0>(arg1)
    }

    public(friend) fun set_admin_fee_share_bp<T0>(arg0: &mut PoolRewards<T0>, arg1: u64) {
        arg0.admin_fee_share_bp = arg1;
    }

    public(friend) fun withdraw_lp<T0>(arg0: &mut PoolRewards<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::lp_amount<T0>(arg1) >= arg2, 0);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::remove<T0>(arg1, arg2, arg0.acc_reward_per_share_p);
        assert!(arg0.lp_supply >= arg2, 1);
        arg0.lp_supply = arg0.lp_supply - arg2;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.rewards, pending_rewards<T0>(arg0, arg1)), arg3)
    }

    // decompiled from Move bytecode v6
}

