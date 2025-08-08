module 0xbc1c1b32c276da121d8b31902119ca8c78ecc04933de9e4de83d55f5af579c78::launchpad_manager_config {
    struct LaunchpadManagerConfig has store, key {
        id: 0x2::object::UID,
        configs: 0x2::table::Table<u8, LaunchConfig>,
        launchpad_fee: u64,
    }

    struct LaunchConfig has drop, store {
        level: u8,
        add_liquidity_fee_rate: u64,
        transaction_fee_rate: u64,
        fudraising_fee_rate: u64,
    }

    struct LaunchAdmin has key {
        id: 0x2::object::UID,
    }

    struct LaunchManagerAdmin has key {
        id: 0x2::object::UID,
    }

    public fun get_lanch_config_by_level(arg0: u8, arg1: &LaunchpadManagerConfig) : (u64, u64, u64) {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        };
        assert!(v0, 11);
        let v1 = 0x2::table::borrow<u8, LaunchConfig>(&arg1.configs, arg0);
        if (arg0 == 1) {
            (v1.add_liquidity_fee_rate, v1.transaction_fee_rate, v1.fudraising_fee_rate)
        } else if (arg0 == 0) {
            (v1.add_liquidity_fee_rate, v1.transaction_fee_rate, v1.fudraising_fee_rate)
        } else {
            (v1.add_liquidity_fee_rate, v1.transaction_fee_rate, v1.fudraising_fee_rate)
        }
    }

    public fun get_launch_config_by_level(arg0: u8, arg1: &LaunchpadManagerConfig) : (u64, u64, u64) {
        let v0 = 0x2::table::borrow<u8, LaunchConfig>(&arg1.configs, arg0);
        (v0.add_liquidity_fee_rate, v0.transaction_fee_rate, v0.fudraising_fee_rate)
    }

    public fun get_launchpad_fee(arg0: &LaunchpadManagerConfig) : u64 {
        arg0.launchpad_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, LaunchConfig>(arg0);
        let v1 = LaunchConfig{
            level                  : 0,
            add_liquidity_fee_rate : 10,
            transaction_fee_rate   : 0,
            fudraising_fee_rate    : 0,
        };
        0x2::table::add<u8, LaunchConfig>(&mut v0, 0, v1);
        let v2 = LaunchConfig{
            level                  : 1,
            add_liquidity_fee_rate : 10,
            transaction_fee_rate   : 0,
            fudraising_fee_rate    : 0,
        };
        0x2::table::add<u8, LaunchConfig>(&mut v0, 1, v2);
        let v3 = LaunchConfig{
            level                  : 2,
            add_liquidity_fee_rate : 10,
            transaction_fee_rate   : 0,
            fudraising_fee_rate    : 0,
        };
        0x2::table::add<u8, LaunchConfig>(&mut v0, 2, v3);
        let v4 = LaunchpadManagerConfig{
            id            : 0x2::object::new(arg0),
            configs       : v0,
            launchpad_fee : 1000,
        };
        0x2::transfer::share_object<LaunchpadManagerConfig>(v4);
        let v5 = LaunchManagerAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchManagerAdmin>(v5, 0x2::tx_context::sender(arg0));
        let v6 = LaunchAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchAdmin>(v6, 0x2::tx_context::sender(arg0));
    }

    public fun set_launch_admin(arg0: &LaunchManagerAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchAdmin{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<LaunchAdmin>(v0, arg1);
    }

    public fun set_launch_config_add_liquidity_fee_rate(arg0: &mut LaunchpadManagerConfig, arg1: &LaunchManagerAdmin, arg2: u8, arg3: u64) {
        0x2::table::borrow_mut<u8, LaunchConfig>(&mut arg0.configs, arg2).add_liquidity_fee_rate = arg3;
    }

    public fun set_launch_config_fudraising_fee_rate(arg0: &mut LaunchpadManagerConfig, arg1: &LaunchManagerAdmin, arg2: u8, arg3: u64) {
        0x2::table::borrow_mut<u8, LaunchConfig>(&mut arg0.configs, arg2).fudraising_fee_rate = arg3;
    }

    public fun set_launch_config_transaction_fee_rate(arg0: &mut LaunchpadManagerConfig, arg1: &LaunchManagerAdmin, arg2: u8, arg3: u64) {
        0x2::table::borrow_mut<u8, LaunchConfig>(&mut arg0.configs, arg2).transaction_fee_rate = arg3;
    }

    public fun set_launchpad_fee(arg0: &mut LaunchpadManagerConfig, arg1: &LaunchManagerAdmin, arg2: u64) {
        arg0.launchpad_fee = arg2;
    }

    public fun update_launch_manager_admin(arg0: LaunchManagerAdmin, arg1: address) {
        0x2::transfer::transfer<LaunchManagerAdmin>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

