module 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist_vault_inner {
    struct WhitelistVaultInner has store {
        custodian: address,
        deposit: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        allowance: 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::Allowance,
        total_supply: u64,
        instant_withdrawal_quota: u64,
        whitelist: 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::Whitelist,
    }

    struct Deposit has copy, drop {
        amount: u64,
    }

    struct MintRcUSD has copy, drop {
        amount: u64,
    }

    struct InstantWithdraw has copy, drop {
        amount: u64,
    }

    struct PendingWithdraw has copy, drop {
        amount: u64,
        receipt_id: 0x2::object::ID,
    }

    struct Claim has copy, drop {
        amount: u64,
        receipt_id: 0x2::object::ID,
    }

    struct InstantWithdrawalQuotaReset has copy, drop {
        quota: u64,
    }

    struct TopUp has copy, drop {
        amount: u64,
        previous_funds: u64,
        new_funds: u64,
    }

    struct ExtractFunds has copy, drop {
        amount: u64,
        previous_funds: u64,
        new_funds: u64,
    }

    struct SetCustodian has copy, drop {
        previous_custodian: address,
        new_custodian: address,
    }

    public(friend) fun new(arg0: address, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::Allowance, arg3: u64, arg4: u64, arg5: 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::Whitelist) : WhitelistVaultInner {
        WhitelistVaultInner{
            custodian                : arg0,
            deposit                  : arg1,
            allowance                : arg2,
            total_supply             : arg3,
            instant_withdrawal_quota : arg4,
            whitelist                : arg5,
        }
    }

    public(friend) fun allowance(arg0: &WhitelistVaultInner) : &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::Allowance {
        &arg0.allowance
    }

    public(friend) fun whitelist(arg0: &WhitelistVaultInner) : &0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::Whitelist {
        &arg0.whitelist
    }

    public(friend) fun allowance_mut(arg0: &mut WhitelistVaultInner) : &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::Allowance {
        &mut arg0.allowance
    }

    public(friend) fun claim(arg0: &mut WhitelistVaultInner, arg1: 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::ClaimReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::withdrawn_amount(&arg1);
        assert!(is_claim_ready(0x2::clock::timestamp_ms(arg2), 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::request_timestamp(&arg1)), 3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit) >= v0, 5);
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::destroy(arg1);
        let v1 = Claim{
            amount     : v0,
            receipt_id : 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::id(&arg1),
        };
        0x2::event::emit<Claim>(v1);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposit, v0), arg3)
    }

    public(friend) fun custodian(arg0: &WhitelistVaultInner) : address {
        arg0.custodian
    }

    public(friend) fun deposit(arg0: &mut WhitelistVaultInner, arg1: &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD> {
        assert!(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::contains(&arg0.whitelist, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        let v1 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::mint_cumulative_amount(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::wallet_state(&arg0.whitelist, 0x2::tx_context::sender(arg3)));
        assert!(arg0.total_supply + v0 <= 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::max_supply(&arg0.allowance), 1);
        assert!(v1 + v0 <= 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::per_wallet_mint_limit(&arg0.allowance), 2);
        arg0.total_supply = arg0.total_supply + v0;
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_mint_cumulative_amount(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::wallet_state_mut(&mut arg0.whitelist, 0x2::tx_context::sender(arg3)), v1 + v0);
        let v2 = Deposit{amount: v0};
        0x2::event::emit<Deposit>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg2, arg0.custodian);
        0x2::coin::mint<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(arg1), v0, arg3)
    }

    public(friend) fun deposit_value(arg0: &WhitelistVaultInner) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit)
    }

    public(friend) fun extract_funds(arg0: &mut WhitelistVaultInner, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit) >= arg1, 5);
        let v0 = ExtractFunds{
            amount         : arg1,
            previous_funds : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit),
            new_funds      : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit),
        };
        0x2::event::emit<ExtractFunds>(v0);
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposit, arg1), arg2)
    }

    public(friend) fun instant_withdrawal_quota(arg0: &WhitelistVaultInner) : u64 {
        arg0.instant_withdrawal_quota
    }

    public(friend) fun is_claim_ready(arg0: u64, arg1: u64) : bool {
        if (arg0 <= arg1) {
            return false
        };
        let v0 = (arg1 + 61200000) / 86400000 * 86400000 - 28800000;
        let v1 = (arg0 - 25200000) / 86400000 * 86400000 - 28800000;
        v1 > v0 && v1 - v0 >= 86400000
    }

    public(friend) fun mint_rcusd(arg0: &mut WhitelistVaultInner, arg1: &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD> {
        assert!(arg0.total_supply + arg2 <= 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::max_supply(&arg0.allowance), 1);
        arg0.total_supply = arg0.total_supply + arg2;
        let v0 = MintRcUSD{amount: arg2};
        0x2::event::emit<MintRcUSD>(v0);
        0x2::coin::mint<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(arg1), arg2, arg3)
    }

    public(friend) fun reset_instant_withdrawal_quota(arg0: &mut WhitelistVaultInner) {
        arg0.instant_withdrawal_quota = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::daily_system_withdraw_limit(&arg0.allowance);
        let v0 = InstantWithdrawalQuotaReset{quota: arg0.instant_withdrawal_quota};
        0x2::event::emit<InstantWithdrawalQuotaReset>(v0);
    }

    public(friend) fun set_custodian(arg0: &mut WhitelistVaultInner, arg1: address) {
        arg0.custodian = arg1;
        let v0 = SetCustodian{
            previous_custodian : arg0.custodian,
            new_custodian      : arg1,
        };
        0x2::event::emit<SetCustodian>(v0);
    }

    public(friend) fun top_up(arg0: &mut WhitelistVaultInner, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposit, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1));
        let v0 = TopUp{
            amount         : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1),
            previous_funds : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit),
            new_funds      : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit),
        };
        0x2::event::emit<TopUp>(v0);
    }

    public(friend) fun total_supply(arg0: &WhitelistVaultInner) : u64 {
        arg0.total_supply
    }

    public(friend) fun whitelist_mut(arg0: &mut WhitelistVaultInner) : &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::Whitelist {
        &mut arg0.whitelist
    }

    public(friend) fun withdraw(arg0: &mut WhitelistVaultInner, arg1: &mut 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::ManagedTreasury<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>, arg2: 0x2::coin::Coin<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::contains(&arg0.whitelist, 0x2::tx_context::sender(arg4)), 0);
        assert!(0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&arg2) >= 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::min_withdrawal_amount(&arg0.allowance), 4);
        let v0 = 0x2::coin::value<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(&arg2);
        let v1 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::whitelist::wallet_state_mut(&mut arg0.whitelist, 0x2::tx_context::sender(arg4));
        0x2::coin::burn<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::treasuryrc::treasury_cap_mut<0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::rcusd::RCUSD>(arg1), arg2);
        let v2 = arg0.total_supply > v0;
        let v3 = if (v2) {
            arg0.total_supply - v0
        } else {
            0
        };
        arg0.total_supply = v3;
        let v4 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::instant_withdrawal_last_reset_time(v1);
        if (v4 == 0) {
            0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_instant_withdrawal_remaining(v1, 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::daily_wallet_withdraw_limit(&arg0.allowance));
            0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_instant_withdrawal_last_reset_time(v1, 0x2::clock::timestamp_ms(arg3));
        } else {
            let v5 = 0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::new(0x2::clock::timestamp_ms(arg3));
            let v6 = 0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::new(0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::instant_withdrawal_last_reset_time(v1));
            let v7 = if (0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::year(&v6) != 0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::year(&v5)) {
                true
            } else if (0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::month(&v6) != 0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::month(&v5)) {
                true
            } else {
                0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::day(&v6) != 0xac8414fad5c2283ad717db34e2c75893759a2265e488e3b78f7d75cbe40fa729::date::day(&v5)
            };
            if (v7) {
                0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_instant_withdrawal_remaining(v1, 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::allowance::daily_wallet_withdraw_limit(&arg0.allowance));
                0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_instant_withdrawal_last_reset_time(v1, 0x2::clock::timestamp_ms(arg3));
            };
        };
        let v8 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::mint_cumulative_amount(v1) > v0;
        let v9 = if (v8) {
            0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::mint_cumulative_amount(v1) - v0
        } else {
            0
        };
        0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_mint_cumulative_amount(v1, v9);
        let v10 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::instant_withdrawal_remaining(v1);
        let v11 = arg0.instant_withdrawal_quota;
        let v12 = if (v0 <= v10) {
            if (v0 <= v11) {
                0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.deposit) >= v0
            } else {
                false
            }
        } else {
            false
        };
        let v13 = v12;
        if (v13) {
            arg0.instant_withdrawal_quota = v11 - v0;
            0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::wallet_state::set_instant_withdrawal_remaining(v1, v10 - v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.deposit, v0), arg4), 0x2::tx_context::sender(arg4));
            let v14 = InstantWithdraw{amount: v0};
            0x2::event::emit<InstantWithdraw>(v14);
        } else {
            let v15 = 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::new(v0, 0x2::clock::timestamp_ms(arg3), arg4);
            let v16 = PendingWithdraw{
                amount     : v0,
                receipt_id : 0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::id(&v15),
            };
            0x2::event::emit<PendingWithdraw>(v16);
            0xeec06ffe1b5ce40e121b040955ea8d877446434872b2e65df38aba6956b62634::claim_receipt::transfer(v15, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

