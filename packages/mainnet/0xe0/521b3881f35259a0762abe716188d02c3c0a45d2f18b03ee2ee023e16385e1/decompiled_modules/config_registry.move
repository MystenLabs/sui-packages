module 0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::config_registry {
    struct Config has store, key {
        id: 0x2::object::UID,
        dev_addr: address,
        lp_operator_addr: address,
        pol_treasury_id: 0x2::object::ID,
        mint_vault_id: 0x2::object::ID,
        emergency_fixed_mode: bool,
        fixed_sui_usd_price_bps: u64,
        pyth_state_id: 0x2::object::ID,
        pyth_sui_price_info_id: 0x2::object::ID,
        today_dev_ratio: u64,
        today_pol_ratio: u64,
        nostalgia_dev_ratio: u64,
        nostalgia_pol_ratio: u64,
        today_fee_usd: u64,
        nostalgia_fee_usd: u64,
        reward_today_immediate: u64,
        reward_today_deferred: u64,
        reward_nostalgia_base: u64,
        dev_tvyn_ratio_bps: u64,
        lp_threshold_sui: u64,
        lp_target_ratio_bps: u64,
        default_royalty_bps: u16,
    }

    public entry fun create_and_share_default(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_from_address(@0x0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = Config{
            id                      : 0x2::object::new(arg0),
            dev_addr                : v1,
            lp_operator_addr        : v1,
            pol_treasury_id         : v0,
            mint_vault_id           : v0,
            emergency_fixed_mode    : true,
            fixed_sui_usd_price_bps : 10000,
            pyth_state_id           : v0,
            pyth_sui_price_info_id  : v0,
            today_dev_ratio         : 7500,
            today_pol_ratio         : 2500,
            nostalgia_dev_ratio     : 7500,
            nostalgia_pol_ratio     : 2500,
            today_fee_usd           : 25,
            nostalgia_fee_usd       : 100,
            reward_today_immediate  : 40000000,
            reward_today_deferred   : 40000000,
            reward_nostalgia_base   : 250000000,
            dev_tvyn_ratio_bps      : 100,
            lp_threshold_sui        : 10000000000,
            lp_target_ratio_bps     : 40000,
            default_royalty_bps     : 500,
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun default_royalty_bps(arg0: &Config) : u16 {
        arg0.default_royalty_bps
    }

    public fun dev_addr(arg0: &Config) : address {
        arg0.dev_addr
    }

    public fun dev_tvyn_ratio_bps(arg0: &Config) : u64 {
        arg0.dev_tvyn_ratio_bps
    }

    public fun emergency_fixed_mode(arg0: &Config) : bool {
        arg0.emergency_fixed_mode
    }

    public fun fixed_sui_usd_price_bps(arg0: &Config) : u64 {
        arg0.fixed_sui_usd_price_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun lp_operator_addr(arg0: &Config) : address {
        arg0.lp_operator_addr
    }

    public fun lp_target_ratio_bps(arg0: &Config) : u64 {
        arg0.lp_target_ratio_bps
    }

    public fun lp_threshold_sui(arg0: &Config) : u64 {
        arg0.lp_threshold_sui
    }

    public fun mint_vault_id(arg0: &Config) : 0x2::object::ID {
        arg0.mint_vault_id
    }

    public fun nostalgia_fee_usd(arg0: &Config) : u64 {
        arg0.nostalgia_fee_usd
    }

    public fun nostalgia_ratios(arg0: &Config) : (u64, u64) {
        (arg0.nostalgia_dev_ratio, arg0.nostalgia_pol_ratio)
    }

    public fun pyth_state_id(arg0: &Config) : 0x2::object::ID {
        arg0.pyth_state_id
    }

    public fun pyth_sui_price_info_id(arg0: &Config) : 0x2::object::ID {
        arg0.pyth_sui_price_info_id
    }

    public fun reward_nostalgia_base(arg0: &Config) : u64 {
        arg0.reward_nostalgia_base
    }

    public fun reward_today_deferred(arg0: &Config) : u64 {
        arg0.reward_today_deferred
    }

    public fun reward_today_immediate(arg0: &Config) : u64 {
        arg0.reward_today_immediate
    }

    public entry fun set_dev_addr(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: address) {
        arg1.dev_addr = arg2;
    }

    public entry fun set_dev_tvyn_ratio(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.dev_tvyn_ratio_bps = arg2;
    }

    public entry fun set_emergency_fixed_mode(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.emergency_fixed_mode = arg2;
    }

    public entry fun set_fees_and_ratios(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg1.today_fee_usd = arg2;
        arg1.nostalgia_fee_usd = arg3;
        arg1.today_dev_ratio = arg4;
        arg1.today_pol_ratio = arg5;
        arg1.nostalgia_dev_ratio = arg6;
        arg1.nostalgia_pol_ratio = arg7;
    }

    public entry fun set_fixed_price_bps(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.fixed_sui_usd_price_bps = arg2;
    }

    public entry fun set_links(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        arg1.pol_treasury_id = arg2;
        arg1.mint_vault_id = arg3;
    }

    public entry fun set_lp_operator(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: address) {
        arg1.lp_operator_addr = arg2;
    }

    public entry fun set_lp_params(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.lp_threshold_sui = arg2;
        arg1.lp_target_ratio_bps = arg3;
    }

    public(friend) fun set_mint_vault_id(arg0: &mut Config, arg1: 0x2::object::ID) {
        arg0.mint_vault_id = arg1;
    }

    public entry fun set_pyth_objects(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: 0x2::object::ID, arg3: 0x2::object::ID) {
        arg1.pyth_state_id = arg2;
        arg1.pyth_sui_price_info_id = arg3;
    }

    public entry fun set_rewards(arg0: &0xe0521b3881f35259a0762abe716188d02c3c0a45d2f18b03ee2ee023e16385e1::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        arg1.reward_today_immediate = arg2;
        arg1.reward_today_deferred = arg3;
        arg1.reward_nostalgia_base = arg4;
    }

    public fun today_fee_usd(arg0: &Config) : u64 {
        arg0.today_fee_usd
    }

    public fun today_ratios(arg0: &Config) : (u64, u64) {
        (arg0.today_dev_ratio, arg0.today_pol_ratio)
    }

    // decompiled from Move bytecode v6
}

