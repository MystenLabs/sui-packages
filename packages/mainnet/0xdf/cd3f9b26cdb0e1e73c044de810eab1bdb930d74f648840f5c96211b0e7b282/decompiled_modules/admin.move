module 0xc2a651b4ef30a1985904e7d01de09c370bbd82e3e9dcc4eb514c91d4fbd1bf6e::admin {
    struct UserStats has store {
        total_user: u64,
        total_effective_user: u64,
        total_user_balance: u64,
    }

    struct InvestStats has store {
        total_invested_amount: u64,
        total_sui_invested_unit: u64,
        total_sui_invested_amount: u64,
        total_pre_invested_unit: u64,
        total_pre_invested_amount: u64,
        total_asset_invested: u64,
        total_area_invested: u64,
        total_cumulative_stake: u64,
        total_redemption_pre: u64,
        total_buy_amount: u64,
        total_buy_use_amount: u64,
        total_caimed_stake_team_reward: u64,
        total_caimed_stake_usdt_team_reward: u64,
    }

    struct RewardStats has store {
        total_static_power_distributed: u64,
        total_dynamic_power_distributed: u64,
        total_dynamic_power: u64,
        total_dynamic_power_distributed_amount: u64,
        total_share_reward: u64,
        total_share_rank_dividend_amount: u64,
        current_share_rank_dividend_amount: u64,
        team_reward: u64,
    }

    struct OtherStats has store {
        total_claimed_amount: u64,
        total_claimed_sui: u64,
        total_claimed_handling_fee: u64,
        total_caimed_stake_interest: u64,
        total_caimed_stake_usdt_interest: u64,
        pre_burn_usdt_amount: u64,
        pre_burn_amount: u64,
        total_freeze_user: u64,
        total_pre_buy_quota: u64,
        total_use_pre_buy_quota: u64,
        total_admin_sui_amount: u64,
        total_admin_pre_amount: u64,
    }

    struct TeamCount has store {
        level_1_count: u64,
        level_2_count: u64,
        level_3_count: u64,
        level_4_count: u64,
        level_5_count: u64,
        level_6_count: u64,
        level_7_count: u64,
        level_8_count: u64,
        level_9_count: u64,
    }

    struct GlobalNetworkData has store {
        user_stats: UserStats,
        invest_stats: InvestStats,
        reward_stats: RewardStats,
        other_stats: OtherStats,
        team_count: TeamCount,
    }

    public(friend) fun addTeamReward(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.team_reward = arg0.reward_stats.team_reward + arg1;
    }

    public(friend) fun add_pre_burn_amount(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.other_stats.pre_burn_amount = arg0.other_stats.pre_burn_amount + arg1;
    }

    public(friend) fun add_pre_burn_usdt_amount(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.other_stats.pre_burn_usdt_amount = arg0.other_stats.pre_burn_usdt_amount + arg1;
    }

    public(friend) fun add_total_admin_pre_amount(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.other_stats.total_admin_pre_amount = arg0.other_stats.total_admin_pre_amount + arg1;
    }

    public(friend) fun add_total_admin_sui_amount(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.other_stats.total_admin_sui_amount = arg0.other_stats.total_admin_sui_amount + arg1;
    }

    public(friend) fun add_total_asset_invested(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.invest_stats.total_asset_invested = arg0.invest_stats.total_asset_invested + arg1;
        arg0.invest_stats.total_invested_amount = arg0.invest_stats.total_invested_amount + arg1;
    }

    public(friend) fun add_total_caimed_stake_interest(arg0: &mut GlobalNetworkData, arg1: u64, arg2: u64) {
        arg0.other_stats.total_caimed_stake_interest = arg0.other_stats.total_caimed_stake_interest + arg1;
        arg0.other_stats.total_caimed_stake_usdt_interest = arg0.other_stats.total_caimed_stake_usdt_interest + arg2;
    }

    public(friend) fun add_total_claimed_amount(arg0: &mut GlobalNetworkData, arg1: u64, arg2: u64, arg3: u64) {
        arg0.other_stats.total_claimed_amount = arg0.other_stats.total_claimed_amount + arg1;
        arg0.other_stats.total_claimed_sui = arg0.other_stats.total_claimed_sui + arg2;
        arg0.other_stats.total_claimed_handling_fee = arg0.other_stats.total_claimed_handling_fee + arg3;
    }

    public(friend) fun add_total_cumulative_stake(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.invest_stats.total_cumulative_stake = arg0.invest_stats.total_cumulative_stake + arg1;
    }

    public(friend) fun add_total_dynamic_power(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.total_dynamic_power = arg0.reward_stats.total_dynamic_power + arg1;
    }

    public(friend) fun add_total_dynamic_power_distributed(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.total_dynamic_power_distributed = arg0.reward_stats.total_dynamic_power_distributed + arg1;
        arg0.reward_stats.total_dynamic_power = arg0.reward_stats.total_dynamic_power + arg1;
    }

    public(friend) fun add_total_dynamic_power_distributed_amount(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.total_dynamic_power_distributed_amount = arg0.reward_stats.total_dynamic_power_distributed_amount + arg1;
    }

    public(friend) fun add_total_effective_user(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.user_stats.total_effective_user = arg0.user_stats.total_effective_user + arg1;
    }

    public(friend) fun add_total_freeze_user(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.other_stats.total_freeze_user = arg0.other_stats.total_freeze_user + arg1;
    }

    public(friend) fun add_total_pre_buy_quota(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.other_stats.total_pre_buy_quota = arg0.other_stats.total_pre_buy_quota + arg1;
    }

    public(friend) fun add_total_pre_invested(arg0: &mut GlobalNetworkData, arg1: u64, arg2: u64) {
        arg0.invest_stats.total_pre_invested_unit = arg0.invest_stats.total_pre_invested_unit + arg1;
        arg0.invest_stats.total_pre_invested_amount = arg0.invest_stats.total_pre_invested_amount + arg2;
    }

    public(friend) fun add_total_redemption_pre(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.invest_stats.total_redemption_pre = arg0.invest_stats.total_redemption_pre + arg1;
    }

    public(friend) fun add_total_share_rank_dividend_amount(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.total_share_rank_dividend_amount = arg0.reward_stats.total_share_rank_dividend_amount + arg1;
        arg0.reward_stats.current_share_rank_dividend_amount = arg0.reward_stats.current_share_rank_dividend_amount + arg1;
    }

    public(friend) fun add_total_share_reward(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.total_share_reward = arg0.reward_stats.total_share_reward + arg1;
    }

    public(friend) fun add_total_static_power_distributed(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.reward_stats.total_static_power_distributed = arg0.reward_stats.total_static_power_distributed + arg1;
    }

    public(friend) fun add_total_sui_invested(arg0: &mut GlobalNetworkData, arg1: u64, arg2: u64) {
        arg0.invest_stats.total_sui_invested_unit = arg0.invest_stats.total_sui_invested_unit + arg1;
        arg0.invest_stats.total_sui_invested_amount = arg0.invest_stats.total_sui_invested_amount + arg2;
    }

    public(friend) fun add_total_use_pre_buy_quota(arg0: &mut GlobalNetworkData, arg1: u64, arg2: u64) {
        arg0.other_stats.total_use_pre_buy_quota = arg0.other_stats.total_use_pre_buy_quota + arg1;
        arg0.invest_stats.total_buy_use_amount = arg0.invest_stats.total_buy_use_amount + arg1;
        arg0.invest_stats.total_buy_amount = arg0.invest_stats.total_buy_amount + arg2;
    }

    public(friend) fun add_total_user(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.user_stats.total_user = arg0.user_stats.total_user + arg1;
    }

    public(friend) fun add_total_user_balance(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.user_stats.total_user_balance = arg0.user_stats.total_user_balance + arg1;
    }

    public fun new() : GlobalNetworkData {
        let v0 = UserStats{
            total_user           : 0,
            total_effective_user : 0,
            total_user_balance   : 0,
        };
        let v1 = InvestStats{
            total_invested_amount               : 0,
            total_sui_invested_unit             : 0,
            total_sui_invested_amount           : 0,
            total_pre_invested_unit             : 0,
            total_pre_invested_amount           : 0,
            total_asset_invested                : 0,
            total_area_invested                 : 0,
            total_cumulative_stake              : 0,
            total_redemption_pre                : 0,
            total_buy_amount                    : 0,
            total_buy_use_amount                : 0,
            total_caimed_stake_team_reward      : 0,
            total_caimed_stake_usdt_team_reward : 0,
        };
        let v2 = RewardStats{
            total_static_power_distributed         : 0,
            total_dynamic_power_distributed        : 0,
            total_dynamic_power                    : 0,
            total_dynamic_power_distributed_amount : 0,
            total_share_reward                     : 0,
            total_share_rank_dividend_amount       : 0,
            current_share_rank_dividend_amount     : 0,
            team_reward                            : 0,
        };
        let v3 = OtherStats{
            total_claimed_amount             : 0,
            total_claimed_sui                : 0,
            total_claimed_handling_fee       : 0,
            total_caimed_stake_interest      : 0,
            total_caimed_stake_usdt_interest : 0,
            pre_burn_usdt_amount             : 0,
            pre_burn_amount                  : 0,
            total_freeze_user                : 0,
            total_pre_buy_quota              : 0,
            total_use_pre_buy_quota          : 0,
            total_admin_sui_amount           : 0,
            total_admin_pre_amount           : 0,
        };
        let v4 = TeamCount{
            level_1_count : 0,
            level_2_count : 0,
            level_3_count : 0,
            level_4_count : 0,
            level_5_count : 0,
            level_6_count : 0,
            level_7_count : 0,
            level_8_count : 0,
            level_9_count : 0,
        };
        GlobalNetworkData{
            user_stats   : v0,
            invest_stats : v1,
            reward_stats : v2,
            other_stats  : v3,
            team_count   : v4,
        }
    }

    public(friend) fun set_total_area_invested(arg0: &mut GlobalNetworkData, arg1: u64) {
        arg0.invest_stats.total_area_invested = arg1;
    }

    public(friend) fun sub_total_asset_invested(arg0: &mut GlobalNetworkData, arg1: u64) {
        if (arg0.invest_stats.total_asset_invested > arg1) {
            arg0.invest_stats.total_asset_invested = arg0.invest_stats.total_asset_invested - arg1;
        };
    }

    public(friend) fun sub_total_dynamic_power(arg0: &mut GlobalNetworkData, arg1: u64) {
        if (arg0.reward_stats.total_dynamic_power > arg1) {
            arg0.reward_stats.total_dynamic_power = arg0.reward_stats.total_dynamic_power - arg1;
        };
    }

    public(friend) fun sub_total_effective_user(arg0: &mut GlobalNetworkData, arg1: u64) {
        if (arg0.user_stats.total_effective_user > arg1) {
            arg0.user_stats.total_effective_user = arg0.user_stats.total_effective_user - arg1;
        };
    }

    public(friend) fun sub_total_freeze_user(arg0: &mut GlobalNetworkData, arg1: u64) {
        if (arg0.other_stats.total_freeze_user > arg1) {
            arg0.other_stats.total_freeze_user = arg0.other_stats.total_freeze_user - arg1;
        };
    }

    public(friend) fun sub_total_user_balance(arg0: &mut GlobalNetworkData, arg1: u64) {
        if (arg0.user_stats.total_user_balance > arg1) {
            arg0.user_stats.total_user_balance = arg0.user_stats.total_user_balance - arg1;
        };
    }

    public(friend) fun updateLevel(arg0: &mut GlobalNetworkData, arg1: u8, arg2: u8) {
        if (arg1 == arg2) {
            return
        };
        if (arg1 >= 1 && arg1 <= 9) {
            let v0 = &arg1;
            if (*v0 == 1) {
                if (arg0.team_count.level_1_count > 0) {
                    arg0.team_count.level_1_count = arg0.team_count.level_1_count - 1;
                };
            } else if (*v0 == 2) {
                if (arg0.team_count.level_2_count > 0) {
                    arg0.team_count.level_2_count = arg0.team_count.level_2_count - 1;
                };
            } else if (*v0 == 3) {
                if (arg0.team_count.level_3_count > 0) {
                    arg0.team_count.level_3_count = arg0.team_count.level_3_count - 1;
                };
            } else if (*v0 == 4) {
                if (arg0.team_count.level_4_count > 0) {
                    arg0.team_count.level_4_count = arg0.team_count.level_4_count - 1;
                };
            } else if (*v0 == 5) {
                if (arg0.team_count.level_5_count > 0) {
                    arg0.team_count.level_5_count = arg0.team_count.level_5_count - 1;
                };
            } else if (*v0 == 6) {
                if (arg0.team_count.level_6_count > 0) {
                    arg0.team_count.level_6_count = arg0.team_count.level_6_count - 1;
                };
            } else if (*v0 == 7) {
                if (arg0.team_count.level_7_count > 0) {
                    arg0.team_count.level_7_count = arg0.team_count.level_7_count - 1;
                };
            } else if (*v0 == 8) {
                if (arg0.team_count.level_8_count > 0) {
                    arg0.team_count.level_8_count = arg0.team_count.level_8_count - 1;
                };
            } else if (*v0 == 9) {
                if (arg0.team_count.level_9_count > 0) {
                    arg0.team_count.level_9_count = arg0.team_count.level_9_count - 1;
                };
            };
        };
        if (arg2 >= 1 && arg2 <= 9) {
            let v1 = &arg2;
            if (*v1 == 1) {
                arg0.team_count.level_1_count = arg0.team_count.level_1_count + 1;
            } else if (*v1 == 2) {
                arg0.team_count.level_2_count = arg0.team_count.level_2_count + 1;
            } else if (*v1 == 3) {
                arg0.team_count.level_3_count = arg0.team_count.level_3_count + 1;
            } else if (*v1 == 4) {
                arg0.team_count.level_4_count = arg0.team_count.level_4_count + 1;
            } else if (*v1 == 5) {
                arg0.team_count.level_5_count = arg0.team_count.level_5_count + 1;
            } else if (*v1 == 6) {
                arg0.team_count.level_6_count = arg0.team_count.level_6_count + 1;
            } else if (*v1 == 7) {
                arg0.team_count.level_7_count = arg0.team_count.level_7_count + 1;
            } else if (*v1 == 8) {
                arg0.team_count.level_8_count = arg0.team_count.level_8_count + 1;
            } else if (*v1 == 9) {
                arg0.team_count.level_9_count = arg0.team_count.level_9_count + 1;
            };
        };
    }

    // decompiled from Move bytecode v6
}

