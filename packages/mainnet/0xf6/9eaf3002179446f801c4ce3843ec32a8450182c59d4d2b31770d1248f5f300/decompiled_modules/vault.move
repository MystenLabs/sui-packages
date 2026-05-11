module 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::vault {
    struct VaultConfig has copy, drop, store {
        bonding_curve_tax_bps: u16,
        post_graduation_tax_bps: u16,
        payout_kind: u8,
        distribution_interval_hours: u16,
        graduation_market_cap_sui: u64,
        total_supply: u64,
        launched_at_ms: u64,
        anti_snipe_until_ms: u64,
        max_wallet_until_ms: u64,
        max_wallet_amount: u64,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        config: VaultConfig,
        phase: u8,
        tax_token_balance: 0x2::balance::Balance<T0>,
        dividend_payout_pool: 0x2::balance::Balance<T1>,
        exempt: 0x2::vec_set::VecSet<address>,
        last_tick_ms: u64,
        cumulative_distributed: u64,
    }

    public(friend) fun new<T0, T1>(arg0: u16, arg1: u16, arg2: u8, arg3: u16, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        assert!(arg5 > 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_vault_zero_supply());
        let v0 = VaultConfig{
            bonding_curve_tax_bps       : arg0,
            post_graduation_tax_bps     : arg1,
            payout_kind                 : arg2,
            distribution_interval_hours : arg3,
            graduation_market_cap_sui   : arg4,
            total_supply                : arg5,
            launched_at_ms              : arg6,
            anti_snipe_until_ms         : arg7,
            max_wallet_until_ms         : arg8,
            max_wallet_amount           : arg9,
        };
        Vault<T0, T1>{
            id                     : 0x2::object::new(arg10),
            config                 : v0,
            phase                  : 0,
            tax_token_balance      : 0x2::balance::zero<T0>(),
            dividend_payout_pool   : 0x2::balance::zero<T1>(),
            exempt                 : 0x2::vec_set::empty<address>(),
            last_tick_ms           : arg6,
            cumulative_distributed : 0,
        }
    }

    public(friend) fun add_distributed<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.cumulative_distributed = arg0.cumulative_distributed + arg1;
    }

    public(friend) fun add_exempt<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: address) {
        if (0x2::vec_set::contains<address>(&arg0.exempt, &arg1)) {
            return
        };
        0x2::vec_set::insert<address>(&mut arg0.exempt, arg1);
    }

    public fun anti_snipe_until_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.config.anti_snipe_until_ms
    }

    public fun bonding_curve_tax_bps<T0, T1>(arg0: &Vault<T0, T1>) : u16 {
        arg0.config.bonding_curve_tax_bps
    }

    public fun cumulative_distributed<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.cumulative_distributed
    }

    public fun current_tax_bps<T0, T1>(arg0: &Vault<T0, T1>) : u16 {
        if (arg0.phase == 0) {
            arg0.config.bonding_curve_tax_bps
        } else {
            arg0.config.post_graduation_tax_bps
        }
    }

    public(friend) fun deposit_payout<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T1>(&mut arg0.dividend_payout_pool, arg1);
    }

    public(friend) fun deposit_tax<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.tax_token_balance, arg1);
    }

    public fun distribution_interval_hours<T0, T1>(arg0: &Vault<T0, T1>) : u16 {
        arg0.config.distribution_interval_hours
    }

    public fun exempt_addresses<T0, T1>(arg0: &Vault<T0, T1>) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.exempt)
    }

    public fun graduation_market_cap_sui<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.config.graduation_market_cap_sui
    }

    public fun is_exempt<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.exempt, &arg1)
    }

    public fun is_graduated<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.phase == 1
    }

    public fun last_tick<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.last_tick_ms
    }

    public fun launched_at_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.config.launched_at_ms
    }

    public(friend) fun mark_graduated<T0, T1>(arg0: &mut Vault<T0, T1>) {
        assert!(arg0.phase == 0, 0xf69eaf3002179446f801c4ce3843ec32a8450182c59d4d2b31770d1248f5f300::errors::e_already_graduated());
        arg0.phase = 1;
    }

    public fun max_wallet_amount<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.config.max_wallet_amount
    }

    public fun max_wallet_until_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.config.max_wallet_until_ms
    }

    public fun payout_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.dividend_payout_pool)
    }

    public fun payout_kind<T0, T1>(arg0: &Vault<T0, T1>) : u8 {
        arg0.config.payout_kind
    }

    public fun payout_kind_sui() : u8 {
        0
    }

    public fun payout_kind_usdc() : u8 {
        1
    }

    public fun phase<T0, T1>(arg0: &Vault<T0, T1>) : u8 {
        arg0.phase
    }

    public fun phase_bonding_curve() : u8 {
        0
    }

    public fun phase_graduated() : u8 {
        1
    }

    public fun post_graduation_tax_bps<T0, T1>(arg0: &Vault<T0, T1>) : u16 {
        arg0.config.post_graduation_tax_bps
    }

    public(friend) fun set_last_tick<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        arg0.last_tick_ms = arg1;
    }

    public(friend) fun share<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public(friend) fun take_payout<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) : 0x2::balance::Balance<T1> {
        0x2::balance::split<T1>(&mut arg0.dividend_payout_pool, arg1)
    }

    public(friend) fun take_tax<T0, T1>(arg0: &mut Vault<T0, T1>) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.tax_token_balance, 0x2::balance::value<T0>(&arg0.tax_token_balance))
    }

    public fun tax_balance<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.tax_token_balance)
    }

    public fun total_supply<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.config.total_supply
    }

    // decompiled from Move bytecode v6
}

