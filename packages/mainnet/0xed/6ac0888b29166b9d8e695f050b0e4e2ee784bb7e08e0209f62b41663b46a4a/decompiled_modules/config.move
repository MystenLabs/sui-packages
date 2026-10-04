module 0x9bfc75bf751fe12e2ccad996f19b2ab3a8c1c9c60f5b4e7a41d8ce153e72aad2::config {
    struct AdminConfigCap has key {
        id: 0x2::object::UID,
    }

    struct AppConfig has key {
        id: 0x2::object::UID,
        version: u64,
        admin: vector<address>,
        mint_enabled: bool,
        upgrade_enabled: bool,
        stake_enabled: bool,
        unstake_enabled: bool,
        phase1_enabled: bool,
        cosmo_enabled: bool,
        reward_enabled: bool,
    }

    entry fun add_admin(arg0: &AdminConfigCap, arg1: &mut AppConfig, arg2: address) {
        assert!(!0x1::vector::contains<address>(&arg1.admin, &arg2), 105);
        0x1::vector::push_back<address>(&mut arg1.admin, arg2);
    }

    public fun check_admin(arg0: &AppConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.admin, &v0), 105);
    }

    public fun check_cosmo_enabled(arg0: &AppConfig) {
        assert!(arg0.cosmo_enabled, 108);
    }

    public fun check_mint_enabled(arg0: &AppConfig) {
        assert!(arg0.mint_enabled, 101);
    }

    public fun check_phase1_enabled(arg0: &AppConfig) {
        assert!(arg0.phase1_enabled, 107);
    }

    public fun check_reward_enabled(arg0: &AppConfig) {
        assert!(arg0.reward_enabled, 109);
    }

    public fun check_stake_enabled(arg0: &AppConfig) {
        assert!(arg0.stake_enabled, 103);
    }

    public fun check_unstake_enabled(arg0: &AppConfig) {
        assert!(arg0.unstake_enabled, 104);
    }

    public fun check_upgrade_enabled(arg0: &AppConfig) {
        assert!(arg0.upgrade_enabled, 102);
    }

    public fun check_version(arg0: &AppConfig) {
        assert!(arg0.version == 1, 100);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminConfigCap>(v1, v0);
        let v2 = vector[];
        0x1::vector::push_back<address>(&mut v2, v0);
        let v3 = AppConfig{
            id              : 0x2::object::new(arg0),
            version         : 1,
            admin           : v2,
            mint_enabled    : false,
            upgrade_enabled : false,
            stake_enabled   : false,
            unstake_enabled : false,
            phase1_enabled  : false,
            cosmo_enabled   : false,
            reward_enabled  : false,
        };
        0x2::transfer::share_object<AppConfig>(v3);
    }

    public fun migrate(arg0: &AdminConfigCap, arg1: &mut AppConfig) {
        assert!(arg1.version < 1, 100);
        arg1.version = 1;
    }

    entry fun migrate_version(arg0: &AdminConfigCap, arg1: &mut AppConfig) {
        migrate(arg0, arg1);
    }

    public fun package_version() : u64 {
        1
    }

    entry fun remove_admin(arg0: &AdminConfigCap, arg1: &mut AppConfig, arg2: address) {
        assert!(0x1::vector::length<address>(&arg1.admin) > 1, 106);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.admin, &arg2);
        assert!(v0, 105);
        0x1::vector::remove<address>(&mut arg1.admin, v1);
    }

    entry fun set_cosmo_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.cosmo_enabled = arg1;
    }

    entry fun set_mint_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.mint_enabled = arg1;
    }

    entry fun set_phase1_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.phase1_enabled = arg1;
    }

    entry fun set_reward_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.reward_enabled = arg1;
    }

    entry fun set_stake_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.stake_enabled = arg1;
    }

    entry fun set_unstake_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.unstake_enabled = arg1;
    }

    entry fun set_upgrade_enabled(arg0: &mut AppConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.upgrade_enabled = arg1;
    }

    // decompiled from Move bytecode v7
}

