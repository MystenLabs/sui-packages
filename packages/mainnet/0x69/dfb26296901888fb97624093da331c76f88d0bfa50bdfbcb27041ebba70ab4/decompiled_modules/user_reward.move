module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::user_reward {
    struct UserRewardKey has copy, drop, store {
        owner: address,
        reserve: address,
        token_type: 0x1::string::String,
        option: u8,
    }

    struct UserReward<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        reserve: address,
        option: u8,
        token_type: 0x1::string::String,
        user_reward_index: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        earned_amount: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        claimed_amount: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        phase: u16,
    }

    struct NewUserRewardEvent has copy, drop {
        user: address,
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        option: u8,
        reward_token_type: 0x1::string::String,
        user_reward_index_sf: u256,
        phase: u16,
    }

    struct UpdateUserRewardEvent has copy, drop {
        user: address,
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        option: u8,
        reward_token_type: 0x1::string::String,
        user_reward_index_sf: u256,
        earned_amount_sf: u256,
        phase: u16,
    }

    struct ClaimUserRewardEvent has copy, drop {
        user: address,
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        reward_token_type: 0x1::string::String,
        claim_amount: u64,
        total_claimed_amount_sf: u256,
        option: u8,
    }

    public(friend) fun new<T0, T1>(arg0: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::Obligation<T0>, arg1: address, arg2: u8, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>();
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::owner<T0>(arg0);
        let v2 = UserReward<T0>{
            id                : 0x2::object::new(arg4),
            owner             : v1,
            reserve           : arg1,
            option            : arg2,
            token_type        : v0,
            user_reward_index : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            earned_amount     : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            claimed_amount    : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            phase             : arg3,
        };
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::add<UserRewardKey, UserReward<T0>, T0>(arg0, new_user_reward_key(v1, arg1, v0, arg2), v2);
        let v3 = NewUserRewardEvent{
            user                 : 0x2::tx_context::sender(arg4),
            reserve              : 0x2::object::id_from_address(arg1),
            market_type          : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
            option               : arg2,
            reward_token_type    : v0,
            user_reward_index_sf : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0)),
            phase                : arg3,
        };
        0x2::event::emit<NewUserRewardEvent>(v3);
    }

    public(friend) fun claim_reward<T0, T1>(arg0: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_reward_state::TokenRewardState, arg1: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::Obligation<T0>, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T1>();
        let v1 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::owner<T0>(arg1);
        let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::borrow_mut<UserRewardKey, UserReward<T0>, T0>(arg1, new_user_reward_key(v1, arg2, v0, arg3));
        let v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(v2.earned_amount, v2.claimed_amount));
        assert!(v3 > 0, 3202);
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_reward_state::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<T1>>(arg0, v0);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T1>(v4, 0x2::token::transfer<T1>(0x2::token::mint<T1>(v4, v3, arg4), v1, arg4), arg4);
        v2.claimed_amount = v2.earned_amount;
        let v9 = ClaimUserRewardEvent{
            user                    : 0x2::tx_context::sender(arg4),
            reserve                 : 0x2::object::id_from_address(arg2),
            market_type             : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
            reward_token_type       : v0,
            claim_amount            : v3,
            total_claimed_amount_sf : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v2.claimed_amount),
            option                  : arg3,
        };
        0x2::event::emit<ClaimUserRewardEvent>(v9);
    }

    public(friend) fun new_user_reward_key(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u8) : UserRewardKey {
        UserRewardKey{
            owner      : arg0,
            reserve    : arg1,
            token_type : arg2,
            option     : arg3,
        }
    }

    public(friend) fun update_user_reward<T0, T1>(arg0: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::Obligation<T0>, arg1: &0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2 == 0 || arg2 == 1, 3201);
        let v0 = if (arg2 == 0) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::calculate_deposit_liquidity<T0, T1>(arg0, arg1)
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::calculate_borrow_liquidity<T0, T1>(arg0, arg1)
        };
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1);
        let v2 = 0x2::object::id_to_address(&v1);
        let v3 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::RewardConfigKey, vector<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::RewardConfig<T0>>, T0, T1>(arg1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::new_reward_config_key(v2, arg2));
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::RewardConfig<T0>>(v3)) {
            let v5 = 0x1::vector::borrow<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::RewardConfig<T0>>(v3, v4);
            let v6 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::reward_token_type<T0>(v5);
            let v7 = new_user_reward_key(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::owner<T0>(arg0), v2, v6, arg2);
            if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::contain<UserRewardKey, UserReward<T0>, T0>(arg0, v7)) {
                let v8 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::obligation::borrow_mut<UserRewardKey, UserReward<T0>, T0>(arg0, v7);
                if (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::gt(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::last_global_reward_index<T0>(v5), v8.user_reward_index)) {
                    v8.earned_amount = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v8.earned_amount, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::sub(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::last_global_reward_index<T0>(v5), v8.user_reward_index), v0));
                    v8.user_reward_index = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::last_global_reward_index<T0>(v5);
                    v8.phase = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config::phase<T0>(v5);
                };
                let v9 = UpdateUserRewardEvent{
                    user                 : 0x2::tx_context::sender(arg3),
                    reserve              : 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg1),
                    market_type          : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
                    option               : arg2,
                    reward_token_type    : v6,
                    user_reward_index_sf : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v8.user_reward_index),
                    earned_amount_sf     : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v8.earned_amount),
                    phase                : v8.phase,
                };
                0x2::event::emit<UpdateUserRewardEvent>(v9);
            };
            v4 = v4 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

