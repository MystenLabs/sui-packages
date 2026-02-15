module 0x76f44875dca6b55ef057f6461bd230452c1902d1be1c29017722dfbd702d9292::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        protocol_fee_bps: u16,
        fee_receiver: address,
        lockup_duration_ms: u64,
        vesting_duration_ms: u64,
        total_token_supply: u64,
        is_fixed_x: bool,
        collect_fee_mode: u8,
        is_quote_y: bool,
        fee_scheduler_mode: u8,
        enable_fee_scheduler: bool,
        enable_dynamic_fee: bool,
        url: 0x1::string::String,
        permissionless: bool,
        whitelisted_deployers: 0x2::vec_set::VecSet<address>,
        whitelisted_quote_tokens: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct FeeVault has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_tier_1: u64,
        fee_tier_2: u64,
        fee_tier_3: u64,
        fee_tier_4: u64,
    }

    struct ProtocolPaused has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct ProtocolFeeUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_fee_bps: u16,
        new_fee_bps: u16,
    }

    struct FeeReceiverUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_receiver: address,
        new_receiver: address,
    }

    struct DeployerWhitelisted has copy, drop {
        config_id: 0x2::object::ID,
        deployer: address,
    }

    struct DeployerRemovedFromWhitelist has copy, drop {
        config_id: 0x2::object::ID,
        deployer: address,
    }

    struct QuoteTokenWhitelisted has copy, drop {
        config_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct QuoteTokenRemovedFromWhitelist has copy, drop {
        config_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct PackageVersionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
    }

    struct TotalTokenSupplyUpdated has copy, drop {
        config_id: 0x2::object::ID,
        old_amount: u64,
        new_amount: u64,
    }

    public fun add_whitelisted_deployer(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert!(!0x2::vec_set::contains<address>(&arg1.whitelisted_deployers, &arg2), 104);
        0x2::vec_set::insert<address>(&mut arg1.whitelisted_deployers, arg2);
        let v0 = DeployerWhitelisted{
            config_id : 0x2::object::id<Config>(arg1),
            deployer  : arg2,
        };
        0x2::event::emit<DeployerWhitelisted>(v0);
    }

    public fun add_whitelisted_quote_token<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelisted_quote_tokens, &v0), 105);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.whitelisted_quote_tokens, v0);
        let v1 = QuoteTokenWhitelisted{
            config_id  : 0x2::object::id<Config>(arg1),
            token_type : v0,
        };
        0x2::event::emit<QuoteTokenWhitelisted>(v1);
    }

    public fun assert_current_version(arg0: &Config) {
        assert!(arg0.version <= 1, 108);
    }

    public fun assert_deployer_whitelisted(arg0: &Config, arg1: address) {
        if (arg0.permissionless) {
            return
        };
        assert!(is_deployer_whitelisted(arg0, arg1), 102);
    }

    public fun assert_fee_receivers_count(arg0: u64) {
        assert!(arg0 <= 10, 106);
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 100);
    }

    public fun assert_positions_count(arg0: u64) {
        assert!(arg0 <= 10, 107);
    }

    public fun assert_quote_token_whitelisted<T0>(arg0: &Config) {
        assert!(is_quote_token_whitelisted<T0>(arg0), 103);
    }

    public fun bps_denominator() : u16 {
        10000
    }

    public fun calculate_protocol_fee(arg0: &Config, arg1: u64) : u64 {
        let v0 = (10000 as u128);
        ((((arg1 as u128) * (arg0.protocol_fee_bps as u128) + v0 - 1) / v0) as u64)
    }

    public fun fee_receiver(arg0: &Config) : address {
        arg0.fee_receiver
    }

    public fun fee_tier(arg0: &FeeVault, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.fee_tier_1
        } else if (arg1 == 2) {
            arg0.fee_tier_2
        } else if (arg1 == 3) {
            arg0.fee_tier_3
        } else {
            arg0.fee_tier_4
        }
    }

    public fun get_launch_config(arg0: &Config) : (bool, u8, bool, u8, bool, bool, 0x1::string::String) {
        (arg0.is_fixed_x, arg0.collect_fee_mode, arg0.is_quote_y, arg0.fee_scheduler_mode, arg0.enable_fee_scheduler, arg0.enable_dynamic_fee, arg0.url)
    }

    public fun get_vault_config(arg0: &Config) : (u64, u64) {
        (arg0.lockup_duration_ms, arg0.vesting_duration_ms)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = Config{
            id                       : 0x2::object::new(arg0),
            version                  : 1,
            paused                   : false,
            protocol_fee_bps         : 0,
            fee_receiver             : v0,
            lockup_duration_ms       : 604800000,
            vesting_duration_ms      : 0,
            total_token_supply       : 1000000000000000,
            is_fixed_x               : true,
            collect_fee_mode         : 1,
            is_quote_y               : true,
            fee_scheduler_mode       : 0,
            enable_fee_scheduler     : true,
            enable_dynamic_fee       : false,
            url                      : 0x1::string::utf8(b"https://octave.finance"),
            permissionless           : false,
            whitelisted_deployers    : 0x2::vec_set::empty<address>(),
            whitelisted_quote_tokens : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v3 = FeeVault{
            id         : 0x2::object::new(arg0),
            balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_tier_1 : 0,
            fee_tier_2 : 200000000,
            fee_tier_3 : 50000000000,
            fee_tier_4 : 75000000000,
        };
        0x2::transfer::share_object<Config>(v2);
        0x2::transfer::share_object<FeeVault>(v3);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public fun is_deployer_whitelisted(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.whitelisted_deployers, &arg1)
    }

    public fun is_fixed_x(arg0: &Config) : bool {
        arg0.is_fixed_x
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_permissionless(arg0: &Config) : bool {
        arg0.permissionless
    }

    public fun is_quote_token_whitelisted<T0>(arg0: &Config) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelisted_quote_tokens, &v0)
    }

    public fun join_fee_vault_balance(arg0: &mut FeeVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun max_fee_receivers() : u64 {
        10
    }

    public fun max_positions() : u64 {
        10
    }

    public fun max_vault_bps() : u16 {
        3000
    }

    public fun protocol_fee_bps(arg0: &Config) : u16 {
        arg0.protocol_fee_bps
    }

    public fun remove_whitelisted_deployer(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert!(0x2::vec_set::contains<address>(&arg1.whitelisted_deployers, &arg2), 102);
        0x2::vec_set::remove<address>(&mut arg1.whitelisted_deployers, &arg2);
        let v0 = DeployerRemovedFromWhitelist{
            config_id : 0x2::object::id<Config>(arg1),
            deployer  : arg2,
        };
        0x2::event::emit<DeployerRemovedFromWhitelist>(v0);
    }

    public fun remove_whitelisted_quote_token<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.whitelisted_quote_tokens, &v0), 103);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.whitelisted_quote_tokens, &v0);
        let v1 = QuoteTokenRemovedFromWhitelist{
            config_id  : 0x2::object::id<Config>(arg1),
            token_type : v0,
        };
        0x2::event::emit<QuoteTokenRemovedFromWhitelist>(v1);
    }

    public fun set_fee_receiver(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.fee_receiver = arg2;
        let v0 = FeeReceiverUpdated{
            config_id    : 0x2::object::id<Config>(arg1),
            old_receiver : arg1.fee_receiver,
            new_receiver : arg2,
        };
        0x2::event::emit<FeeReceiverUpdated>(v0);
    }

    public fun set_fee_tiers(arg0: &AdminCap, arg1: &mut FeeVault, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg1.fee_tier_1 = arg2;
        arg1.fee_tier_2 = arg3;
        arg1.fee_tier_3 = arg4;
        arg1.fee_tier_4 = arg5;
    }

    public fun set_launch_config(arg0: &AdminCap, arg1: &mut Config, arg2: bool, arg3: u8, arg4: bool, arg5: u8, arg6: bool, arg7: bool, arg8: 0x1::string::String) {
        arg1.is_fixed_x = arg2;
        arg1.collect_fee_mode = arg3;
        arg1.is_quote_y = arg4;
        arg1.fee_scheduler_mode = arg5;
        arg1.enable_fee_scheduler = arg6;
        arg1.enable_dynamic_fee = arg7;
        arg1.url = arg8;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ProtocolPaused{
            config_id : 0x2::object::id<Config>(arg1),
            paused    : arg2,
        };
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun set_permissionless(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.permissionless = arg2;
    }

    public fun set_protocol_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u16) {
        assert!(arg2 <= 2000, 101);
        arg1.protocol_fee_bps = arg2;
        let v0 = ProtocolFeeUpdated{
            config_id   : 0x2::object::id<Config>(arg1),
            old_fee_bps : arg1.protocol_fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<ProtocolFeeUpdated>(v0);
    }

    public fun set_total_token_supply(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.total_token_supply = arg2;
        let v0 = TotalTokenSupplyUpdated{
            config_id  : 0x2::object::id<Config>(arg1),
            old_amount : arg1.total_token_supply,
            new_amount : arg2,
        };
        0x2::event::emit<TotalTokenSupplyUpdated>(v0);
    }

    public fun set_vault_config(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64) {
        arg1.lockup_duration_ms = arg2;
        arg1.vesting_duration_ms = arg3;
    }

    public fun total_token_supply(arg0: &Config) : u64 {
        arg0.total_token_supply
    }

    public fun update_package_version(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        let v0 = arg1.version;
        assert!(arg2 > v0, 108);
        arg1.version = arg2;
        let v1 = PackageVersionUpdated{
            config_id   : 0x2::object::id<Config>(arg1),
            old_version : v0,
            new_version : arg2,
        };
        0x2::event::emit<PackageVersionUpdated>(v1);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    public fun withdraw_fee(arg0: &AdminCap, arg1: &Config, arg2: &mut FeeVault, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<0x2::sui::SUI>(&arg2.balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg2.balance), arg3), arg1.fee_receiver);
        };
    }

    // decompiled from Move bytecode v6
}

