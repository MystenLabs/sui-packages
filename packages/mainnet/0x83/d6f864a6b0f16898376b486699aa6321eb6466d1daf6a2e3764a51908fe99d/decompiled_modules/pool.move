module 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StopCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        state: 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::PoolState<T0>,
        rewards: 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::PoolRewards<T0>,
        fee_share_bp: u64,
        can_deposit: bool,
        can_withdraw: bool,
        decimals: u8,
        balance: 0x2::balance::Balance<T0>,
    }

    public(friend) fun balance<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public(friend) fun new<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert!(arg2 <= 10000, 5);
        Pool<T0>{
            id           : 0x2::object::new(arg3),
            state        : 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::new<T0>(arg1),
            rewards      : 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::new<T0>(),
            fee_share_bp : arg2,
            can_deposit  : true,
            can_withdraw : true,
            decimals     : 0x2::coin::get_decimals<T0>(arg0),
            balance      : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun adjust_total_lp_amount<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::d<T0>(&arg0.state);
        let v1 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::lp_supply<T0>(&arg0.rewards);
        if (v0 > v1) {
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::deposit_lp<T0>(&mut arg0.rewards, arg1, v0 - v1, arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    public(friend) fun can_deposit<T0>(arg0: &Pool<T0>) : bool {
        arg0.can_deposit
    }

    public(friend) fun can_withdraw<T0>(arg0: &Pool<T0>) : bool {
        arg0.can_withdraw
    }

    public(friend) fun claim_admin_fee<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::claim_admin_fee<T0>(&mut arg0.rewards, arg1)
    }

    public(friend) fun claim_reward<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::claim_reward<T0>(&mut arg0.rewards, arg1, arg2);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::rewards_claimed_event<T0>(0x2::coin::value<T0>(&v0));
        v0
    }

    public(friend) fun decimals<T0>(arg0: &Pool<T0>) : u8 {
        arg0.decimals
    }

    public(friend) fun deposit<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.can_deposit, 3);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x2::coin::put<T0>(&mut arg0.balance, arg2);
        let v1 = to_system_precision<T0>(arg0, v0);
        let v2 = &mut arg0.state;
        let v3 = &mut arg0.rewards;
        assert!(v1 > 0, 0);
        let v4 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::d<T0>(v2);
        let v5 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(v2) + 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v2);
        if (v4 == 0 || v5 == 0) {
            let v6 = v1 >> 1;
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::add_token_balance<T0>(v2, v6);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::add_vusd_balance<T0>(v2, v6);
        } else {
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::add_token_balance<T0>(v2, v1 * 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(v2) / v5);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::add_vusd_balance<T0>(v2, v1 * 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v2) / v5);
        };
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::update_d<T0>(v2);
        let v7 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::d<T0>(v2) - v4;
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::deposit_event<T0>(v0, v7);
        let v8 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::deposit_lp<T0>(v3, arg1, v7, arg3);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::rewards_claimed_event<T0>(0x2::coin::value<T0>(&v8));
        v8
    }

    public(friend) fun fee_share<T0>(arg0: &Pool<T0>) : u64 {
        arg0.fee_share_bp
    }

    public(friend) fun from_system_precision<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let v0 = arg0.decimals;
        if (v0 > 3) {
            arg1 * 0x1::u64::pow(10, v0 - 3)
        } else {
            arg1 / 0x1::u64::pow(10, 3 - v0)
        }
    }

    fun get_fee<T0>(arg0: &Pool<T0>, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (arg2) {
            return 0x2::coin::zero<T0>(arg3)
        };
        0x2::coin::split<T0>(arg1, 0x2::coin::value<T0>(arg1) - from_system_precision<T0>(arg0, to_system_precision<T0>(arg0, 0x2::coin::value<T0>(arg1) - (((0x2::coin::value<T0>(arg1) as u128) * (arg0.fee_share_bp as u128) / (10000 as u128)) as u64))), arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = StopCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<StopCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun rewards<T0>(arg0: &Pool<T0>) : &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::PoolRewards<T0> {
        &arg0.rewards
    }

    public(friend) fun set_admin_fee_share_bp<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg1 <= 10000, 5);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::set_admin_fee_share_bp<T0>(&mut arg0.rewards, arg1);
    }

    public(friend) fun set_balance_ratio_min_bp<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg1 <= 10000, 5);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::set_balance_ratio_min_bp<T0>(&mut arg0.state, arg1);
    }

    public(friend) fun set_fee_share<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        assert!(arg1 <= 10000, 5);
        arg0.fee_share_bp = arg1;
    }

    public(friend) fun start_deposit<T0>(arg0: &mut Pool<T0>) {
        arg0.can_deposit = true;
    }

    public(friend) fun start_withdraw<T0>(arg0: &mut Pool<T0>) {
        arg0.can_withdraw = true;
    }

    public(friend) fun state<T0>(arg0: &Pool<T0>) : &0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::PoolState<T0> {
        &arg0.state
    }

    public(friend) fun stop_deposit<T0>(arg0: &mut Pool<T0>) {
        arg0.can_deposit = false;
    }

    public(friend) fun stop_withdraw<T0>(arg0: &mut Pool<T0>) {
        arg0.can_withdraw = false;
    }

    public(friend) fun swap_from_vusd<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0;
        let v1 = if (arg1 > 0) {
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::add_vusd_balance<T0>(&mut arg0.state, arg1);
            let v2 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::get_y<T0>(&arg0.state, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(&arg0.state));
            let v3 = if (0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(&arg0.state) > v2) {
                0x2::coin::take<T0>(&mut arg0.balance, from_system_precision<T0>(arg0, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(&arg0.state) - v2), arg4)
            } else {
                0x2::coin::zero<T0>(arg4)
            };
            let v4 = v3;
            let v5 = &mut v4;
            let v6 = get_fee<T0>(arg0, v5, arg3, arg4);
            v0 = 0x2::coin::value<T0>(&v6);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::set_token_balance<T0>(&mut arg0.state, v2);
            assert!(0x2::coin::value<T0>(&v4) >= arg2, 2);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::add_rewards<T0>(&mut arg0.rewards, v6, arg4);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::validate_balance_ratio<T0>(&arg0.state);
            v4
        } else {
            0x2::coin::zero<T0>(arg4)
        };
        let v7 = v1;
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::swapped_from_vusd_event<T0>(0x2::coin::value<T0>(&v7), arg1, v0);
        v7
    }

    public(friend) fun swap_to_vusd<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::coin::value<T0>(&arg1);
        if (v2 > 0) {
            let v3 = &mut arg1;
            let v4 = get_fee<T0>(arg0, v3, arg2, arg3);
            v1 = 0x2::coin::value<T0>(&v4);
            let v5 = &mut arg0.state;
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::add_token_balance<T0>(v5, to_system_precision<T0>(arg0, 0x2::coin::value<T0>(&arg1)));
            let v6 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::get_y<T0>(v5, 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(v5));
            if (0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v5) > v6) {
                v0 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v5) - v6;
            };
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::set_vusd_balance<T0>(v5, v6);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::add_rewards<T0>(&mut arg0.rewards, v4, arg3);
            0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::validate_balance_ratio<T0>(v5);
        };
        assert!(v0 > 0, 1);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::swapped_to_vusd_event<T0>(v2, v0, v1);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        v0
    }

    public(friend) fun to_system_precision<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        let v0 = arg0.decimals;
        if (v0 > 3) {
            arg1 / 0x1::u64::pow(10, v0 - 3)
        } else {
            arg1 * 0x1::u64::pow(10, 3 - v0)
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::user_deposit::UserDeposit<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(arg0.can_withdraw, 4);
        let v0 = &mut arg0.state;
        let v1 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::d<T0>(v0);
        let v2 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_rewards::withdraw_lp<T0>(&mut arg0.rewards, arg1, arg2, arg3);
        let v3 = 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(v0) + 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v0);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::sub_token_balance<T0>(v0, arg2 * 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(v0) / v3);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::sub_vusd_balance<T0>(v0, arg2 * 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v0) / v3);
        assert!(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::token_balance<T0>(v0) + 0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::vusd_balance<T0>(v0) < v3, 1);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::update_d<T0>(v0);
        assert!(0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::pool_state::d<T0>(v0) < v1, 1);
        let v4 = from_system_precision<T0>(arg0, arg2);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::withdraw_event<T0>(v4, arg2);
        0x83d6f864a6b0f16898376b486699aa6321eb6466d1daf6a2e3764a51908fe99d::events::rewards_claimed_event<T0>(0x2::coin::value<T0>(&v2));
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg3), v2)
    }

    // decompiled from Move bytecode v6
}

