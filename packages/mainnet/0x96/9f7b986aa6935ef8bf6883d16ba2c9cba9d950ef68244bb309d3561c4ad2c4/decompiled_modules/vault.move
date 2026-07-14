module 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::vault {
    struct VaultConfig has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        asset: vector<u8>,
        fee_skim_bps: u64,
        auto_deploy_default_off: bool,
        strategy_enabled: bool,
        max_tvl_micros: u64,
        has_max_tvl: bool,
        paused: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        total_assets_micros: u64,
        total_shares: u64,
        liquid_micros: u64,
        deployed_micros: u64,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        shares: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        fee_skim_bps: u64,
        auto_deploy_default_off: bool,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        assets_micros: u64,
        shares_minted: u64,
        fee_micros: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        shares_burned: u64,
        assets_micros: u64,
        fee_micros: u64,
    }

    struct VaultHarvested has copy, drop {
        vault_id: 0x2::object::ID,
        gross_yield_micros: u64,
        protocol_skim_micros: u64,
        net_yield_micros: u64,
        fee_bps: u64,
    }

    public fun apply_harvest_skim(arg0: &VaultConfig, arg1: &mut Vault, arg2: u64) : (u64, u64) {
        let (v0, v1) = 0x425980cb460145b83397586891239f7d570c8a6897581469486225ad06d0a4ef::day::skim_yield(arg2, arg0.fee_skim_bps);
        if (v1 > 0) {
            arg1.total_assets_micros = arg1.total_assets_micros + v1;
            arg1.liquid_micros = arg1.liquid_micros + v1;
        };
        let v2 = VaultHarvested{
            vault_id             : 0x2::object::id<Vault>(arg1),
            gross_yield_micros   : arg2,
            protocol_skim_micros : v0,
            net_yield_micros     : v1,
            fee_bps              : arg0.fee_skim_bps,
        };
        0x2::event::emit<VaultHarvested>(v2);
        (v0, v1)
    }

    public fun auto_deploy_default_off(arg0: &VaultConfig) : bool {
        arg0.auto_deploy_default_off
    }

    public fun convert_to_assets(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u128) * ((arg1 as u128) + (1000 as u128)) / ((arg2 as u128) + (1000 as u128))) as u64)
    }

    public fun convert_to_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 1);
        (((arg0 as u128) * ((arg2 as u128) + (1000 as u128)) / ((arg1 as u128) + (1000 as u128))) as u64)
    }

    public fun create_vault(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        assert!(arg2 <= 10000, 5);
        let v0 = VaultConfig{
            id                      : 0x2::object::new(arg3),
            name                    : arg0,
            asset                   : arg1,
            fee_skim_bps            : arg2,
            auto_deploy_default_off : true,
            strategy_enabled        : false,
            max_tvl_micros          : 0,
            has_max_tvl             : false,
            paused                  : false,
        };
        let v1 = 0x2::object::id<VaultConfig>(&v0);
        let v2 = Vault{
            id                  : 0x2::object::new(arg3),
            config_id           : v1,
            total_assets_micros : 0,
            total_shares        : 0,
            liquid_micros       : 0,
            deployed_micros     : 0,
        };
        let v3 = 0x2::object::id<Vault>(&v2);
        let v4 = VaultCreated{
            vault_id                : v3,
            config_id               : v1,
            fee_skim_bps            : arg2,
            auto_deploy_default_off : true,
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::share_object<VaultConfig>(v0);
        0x2::transfer::share_object<Vault>(v2);
        (v1, v3)
    }

    public fun default_fee_skim_bps() : u64 {
        500
    }

    public fun deposit_liquid(arg0: &VaultConfig, arg1: &mut Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Position {
        assert!(!arg0.paused, 2);
        assert!(arg2 > 0, 1);
        if (arg0.has_max_tvl) {
            assert!(arg1.total_assets_micros + arg2 <= arg0.max_tvl_micros, 6);
        };
        let v0 = convert_to_shares(arg2, arg1.total_assets_micros, arg1.total_shares);
        assert!(v0 > 0, 1);
        arg1.total_assets_micros = arg1.total_assets_micros + arg2;
        arg1.liquid_micros = arg1.liquid_micros + arg2;
        arg1.total_shares = arg1.total_shares + v0;
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Position{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<Vault>(arg1),
            owner    : v1,
            shares   : v0,
        };
        let v3 = Deposited{
            vault_id      : 0x2::object::id<Vault>(arg1),
            owner         : v1,
            assets_micros : arg2,
            shares_minted : v0,
            fee_micros    : 0,
        };
        0x2::event::emit<Deposited>(v3);
        v2
    }

    public fun fee_skim_bps(arg0: &VaultConfig) : u64 {
        arg0.fee_skim_bps
    }

    public fun is_paused(arg0: &VaultConfig) : bool {
        arg0.paused
    }

    public fun liquid_micros(arg0: &Vault) : u64 {
        arg0.liquid_micros
    }

    public fun position_shares(arg0: &Position) : u64 {
        arg0.shares
    }

    public fun price_per_share_micros(arg0: &Vault) : u64 {
        if (arg0.total_shares == 0) {
            return 1000000
        };
        ((((arg0.total_assets_micros as u128) + (1000 as u128)) * 1000000 / ((arg0.total_shares as u128) + (1000 as u128))) as u64)
    }

    public fun require_strategy_for_deploy(arg0: &VaultConfig) {
        assert!(arg0.strategy_enabled, 7);
    }

    public fun set_strategy_enabled(arg0: &mut VaultConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        arg0.strategy_enabled = arg1;
    }

    public fun strategy_enabled(arg0: &VaultConfig) : bool {
        arg0.strategy_enabled
    }

    public fun total_assets(arg0: &Vault) : u64 {
        arg0.total_assets_micros
    }

    public fun total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun withdraw_liquid(arg0: &VaultConfig, arg1: &mut Vault, arg2: &mut Position, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 2);
        assert!(arg3 > 0, 1);
        assert!(arg2.shares >= arg3, 3);
        assert!(0x2::object::id<Vault>(arg1) == arg2.vault_id, 3);
        let v0 = convert_to_assets(arg3, arg1.total_assets_micros, arg1.total_shares);
        assert!(v0 > 0, 1);
        assert!(arg1.liquid_micros >= v0, 4);
        arg2.shares = arg2.shares - arg3;
        arg1.total_shares = arg1.total_shares - arg3;
        arg1.total_assets_micros = arg1.total_assets_micros - v0;
        arg1.liquid_micros = arg1.liquid_micros - v0;
        let v1 = Withdrawn{
            vault_id      : 0x2::object::id<Vault>(arg1),
            owner         : 0x2::tx_context::sender(arg4),
            shares_burned : arg3,
            assets_micros : v0,
            fee_micros    : 0,
        };
        0x2::event::emit<Withdrawn>(v1);
        v0
    }

    // decompiled from Move bytecode v7
}

