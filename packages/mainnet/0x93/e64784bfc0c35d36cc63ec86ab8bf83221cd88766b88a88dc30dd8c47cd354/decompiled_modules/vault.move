module 0x93e64784bfc0c35d36cc63ec86ab8bf83221cd88766b88a88dc30dd8c47cd354::vault {
    struct WithdrawInvestmentEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimRewardsEvent has copy, drop {
        campaign_id: 0x2::object::ID,
        round: u64,
        amount: u64,
    }

    struct Vault<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        scheduled_times: vector<u64>,
        scheduled_rewards: vector<u64>,
        target_amount: u64,
        invested_amount: u64,
        total_rewards: u64,
        reward_balance: 0x2::balance::Balance<T1>,
        investment_balance: 0x2::balance::Balance<T0>,
        start_timestamp: u64,
        investment_receiver: address,
        investment_claimed: bool,
    }

    struct InvestCertificate has store, key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        deposit: u64,
        vesting_applicable_round: u64,
        insured: bool,
    }

    struct WthdrawUnsoldTokensEvent {
        campaign_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun claim<T0, T1>(arg0: &mut InvestCertificate, arg1: &mut Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.campaign_id == arg1.campaign_id, 1);
        let v0 = get_last_applicable_round<T0, T1>(arg1, arg2);
        let v1 = 0;
        assert!(v0 > 0, 6);
        while (arg0.vesting_applicable_round < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg1.scheduled_rewards, arg0.vesting_applicable_round);
            arg0.vesting_applicable_round = arg0.vesting_applicable_round + 1;
        };
        let v2 = get_user_total_reward<T0, T1>(arg1, arg0) * v1 / 100;
        if (v2 != 0) {
            assert!(v2 <= 0x2::balance::value<T1>(&arg1.reward_balance), 5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg1.reward_balance, v2, arg3), 0x2::tx_context::sender(arg3));
            let v3 = ClaimRewardsEvent{
                campaign_id : arg1.campaign_id,
                round       : arg0.vesting_applicable_round,
                amount      : v2,
            };
            0x2::event::emit<ClaimRewardsEvent>(v3);
        };
    }

    public(friend) fun claim_investment<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.investment_receiver == 0x2::tx_context::sender(arg1), 2);
        assert!(!arg0.investment_claimed, 3);
        let v0 = arg0.target_amount;
        if (arg0.invested_amount < arg0.target_amount) {
            v0 = arg0.invested_amount;
        };
        arg0.investment_claimed = true;
        let v1 = WithdrawInvestmentEvent{
            campaign_id : arg0.campaign_id,
            amount      : v0,
        };
        0x2::event::emit<WithdrawInvestmentEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.investment_balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun create<T0, T1>(arg0: 0x2::object::ID, arg1: vector<u64>, arg2: vector<u64>, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        Vault<T0, T1>{
            id                  : 0x2::object::new(arg7),
            campaign_id         : arg0,
            scheduled_times     : arg1,
            scheduled_rewards   : arg2,
            target_amount       : arg3,
            invested_amount     : 0,
            total_rewards       : arg5,
            reward_balance      : 0x2::balance::zero<T1>(),
            investment_balance  : 0x2::balance::zero<T0>(),
            start_timestamp     : arg4,
            investment_receiver : arg6,
            investment_claimed  : false,
        }
    }

    public(friend) fun fund<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T1>(&arg1) >= arg0.total_rewards, 4);
        arg0.total_rewards = 0x2::coin::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.reward_balance, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun get_certificate_campaign_id(arg0: &InvestCertificate) : 0x2::object::ID {
        arg0.campaign_id
    }

    fun get_last_applicable_round<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.scheduled_times) && arg0.start_timestamp + *0x1::vector::borrow<u64>(&arg0.scheduled_times, v0) < 0x2::clock::timestamp_ms(arg1)) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun get_token_price<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        (arg0.target_amount as u128) * 10000000 / (arg0.total_rewards as u128)
    }

    public fun get_tokens_total_rewards_amount<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_rewards
    }

    public fun get_user_total_reward<T0, T1>(arg0: &Vault<T0, T1>, arg1: &InvestCertificate) : u64 {
        (((arg1.deposit as u128) * 10000000 / get_token_price<T0, T1>(arg0)) as u64)
    }

    public(friend) fun mint_investment_certificate<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.invested_amount + 0x2::coin::value<T0>(&arg2) <= arg0.target_amount, 7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        0x2::balance::join<T0>(&mut arg0.investment_balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.invested_amount = arg0.invested_amount + v0;
        let v1 = InvestCertificate{
            id                       : 0x2::object::new(arg4),
            campaign_id              : arg1,
            deposit                  : v0,
            vesting_applicable_round : 0,
            insured                  : arg3,
        };
        0x2::transfer::public_transfer<InvestCertificate>(v1, 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

