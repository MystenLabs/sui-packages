module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault {
    struct WhitelistVault has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    public fun daily_system_withdraw_limit(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::daily_system_withdraw_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance(load_inner(arg0)))
    }

    public fun daily_wallet_withdraw_limit(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::daily_wallet_withdraw_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance(load_inner(arg0)))
    }

    public fun max_supply(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::max_supply(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance(load_inner(arg0)))
    }

    public fun min_withdrawal_amount(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::min_withdrawal_amount(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance(load_inner(arg0)))
    }

    public fun per_wallet_mint_limit(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::per_wallet_mint_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance(load_inner(arg0)))
    }

    public fun set_daily_system_withdraw_limit(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::set_daily_system_withdraw_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance_mut(load_inner_mut(arg0)), arg2);
    }

    public fun set_daily_wallet_withdraw_limit(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::set_daily_wallet_withdraw_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance_mut(load_inner_mut(arg0)), arg2);
    }

    public fun set_max_supply(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::set_max_supply(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance_mut(load_inner_mut(arg0)), arg2);
    }

    public fun set_min_withdrawal_amount(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::set_min_withdrawal_amount(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance_mut(load_inner_mut(arg0)), arg2);
    }

    public fun set_per_wallet_mint_limit(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::set_per_wallet_mint_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance_mut(load_inner_mut(arg0)), arg2);
    }

    public fun add_to_whitelist(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::AssessorCap>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::daily_wallet_withdraw_limit(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::allowance(load_inner(arg0)));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::add(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::whitelist_mut(load_inner_mut(arg0)), arg2, v0);
    }

    public fun claim(arg0: &mut WhitelistVault, arg1: 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::claim_receipt::ClaimReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::claim(load_inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun custodian(arg0: &WhitelistVault) : address {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::custodian(load_inner(arg0))
    }

    public fun deposit(arg0: &mut WhitelistVault, arg1: &mut 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::treasuryrc::ManagedTreasury<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusd::RCUSD>, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusd::RCUSD> {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::deposit(load_inner_mut(arg0), arg1, arg2, arg3)
    }

    public fun deposit_value(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::deposit_value(load_inner(arg0))
    }

    public fun extract_funds(arg0: &mut WhitelistVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert!(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::custodian(load_inner(arg0)) == 0x2::tx_context::sender(arg2), 1);
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::extract_funds(load_inner_mut(arg0), arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistVault{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::WhitelistVaultInner>(1, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::new(@0x0, @0x0, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance::new(20000000000000, 1000000000000, 10000000000, 200000000000, 0), 0, 1000000000000, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::new(arg0)), arg0),
        };
        0x2::transfer::share_object<WhitelistVault>(v0);
    }

    public fun instant_withdrawal_quota(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::instant_withdrawal_quota(load_inner(arg0))
    }

    public fun is_claim_ready(arg0: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::claim_receipt::ClaimReceipt, arg1: u64) : bool {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::is_claim_ready(arg1, 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::claim_receipt::request_timestamp(arg0))
    }

    public fun is_in_whitelist(arg0: &WhitelistVault, arg1: address) : bool {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::contains(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::whitelist(load_inner(arg0)), arg1)
    }

    fun load_inner(arg0: &WhitelistVault) : &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::WhitelistVaultInner {
        assert!(0x2::versioned::version(&arg0.inner) == 1, 0);
        0x2::versioned::load_value<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::WhitelistVaultInner>(&arg0.inner)
    }

    fun load_inner_mut(arg0: &mut WhitelistVault) : &mut 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::WhitelistVaultInner {
        assert!(0x2::versioned::version(&arg0.inner) == 1, 0);
        0x2::versioned::load_value_mut<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::WhitelistVaultInner>(&mut arg0.inner)
    }

    public fun mint_rcusd(arg0: &mut WhitelistVault, arg1: &mut 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::treasuryrc::ManagedTreasury<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusd::RCUSD>, arg2: u64, arg3: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusd::RCUSD> {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg3, 0x2::tx_context::sender(arg4));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::mint_rcusd(load_inner_mut(arg0), arg1, arg2, arg4)
    }

    public fun remove_from_whitelist(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::AssessorCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::remove(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::whitelist_mut(load_inner_mut(arg0)), arg2);
    }

    public fun reset_instant_withdrawal_quota(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg2));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::reset_instant_withdrawal_quota(load_inner_mut(arg0));
    }

    public fun set_custodian(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::set_custodian(load_inner_mut(arg0), arg2);
    }

    public fun set_vault_funder(arg0: &mut WhitelistVault, arg1: &0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::Auth, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::assert_cap<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::auth::ControllerCap>(arg1, 0x2::tx_context::sender(arg3));
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::set_vault_funder(load_inner_mut(arg0), arg2);
    }

    public fun top_up(arg0: &mut WhitelistVault, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::vault_funder(load_inner(arg0)) == 0x2::tx_context::sender(arg2), 2);
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::top_up(load_inner_mut(arg0), arg1);
    }

    public fun total_supply(arg0: &WhitelistVault) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::total_supply(load_inner(arg0))
    }

    public fun vault_funder(arg0: &WhitelistVault) : address {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::vault_funder(load_inner(arg0))
    }

    public fun wallet_instant_withdrawal_last_reset_time(arg0: &WhitelistVault, arg1: address) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::instant_withdrawal_last_reset_time(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::wallet_state(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::whitelist(load_inner(arg0)), arg1))
    }

    public fun wallet_instant_withdrawal_remaining(arg0: &WhitelistVault, arg1: address) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::instant_withdrawal_remaining(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::wallet_state(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::whitelist(load_inner(arg0)), arg1))
    }

    public fun wallet_mint_cumulative_amount(arg0: &WhitelistVault, arg1: address) : u64 {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state::mint_cumulative_amount(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist::wallet_state(0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::whitelist(load_inner(arg0)), arg1))
    }

    public fun withdraw(arg0: &mut WhitelistVault, arg1: &mut 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::treasuryrc::ManagedTreasury<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusd::RCUSD>, arg2: 0x2::coin::Coin<0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::rcusd::RCUSD>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::whitelist_vault_inner::withdraw(load_inner_mut(arg0), arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

