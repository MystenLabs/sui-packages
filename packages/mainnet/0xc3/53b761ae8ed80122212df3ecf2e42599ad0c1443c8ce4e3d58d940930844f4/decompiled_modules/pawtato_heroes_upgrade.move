module 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_heroes_upgrade {
    struct HeroUpgradeStats has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
    }

    struct HeroUpgradeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HeroStatUpgraded has copy, drop {
        user: address,
        hero_id: 0x2::object::ID,
        stat_name: 0x1::string::String,
        old_value: u16,
        new_value: u16,
    }

    struct HeroStatRerolled has copy, drop {
        user: address,
        hero_id: 0x2::object::ID,
        stat_name: 0x1::string::String,
        old_value: u16,
        new_value: u16,
    }

    public entry fun initialize_after_upgrade(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun reroll_hero_stat<T0>(arg0: &mut 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::HeroStakingPool, arg1: &mut HeroUpgradeStats, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::random::Random, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun set_paused(arg0: &HeroUpgradeAdminCap, arg1: &mut HeroUpgradeStats, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.paused = arg2;
    }

    public entry fun upgrade_hero_stat<T0>(arg0: &mut 0xe0fa7b75a3dc8137b38bceb0c0c21c10e0f57c408fe9068694f58fd21e071925::pawtato_hero_staking::HeroStakingPool, arg1: &mut HeroUpgradeStats, arg2: &mut 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_resources::PawtatoResources, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun upgrade_version(arg0: &HeroUpgradeAdminCap, arg1: &mut HeroUpgradeStats, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

