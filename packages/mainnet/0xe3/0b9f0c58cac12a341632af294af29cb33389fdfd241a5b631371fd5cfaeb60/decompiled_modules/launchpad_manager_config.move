module 0xe30b9f0c58cac12a341632af294af29cb33389fdfd241a5b631371fd5cfaeb60::launchpad_manager_config {
    struct LaunchpadManagerConfig has store, key {
        id: 0x2::object::UID,
        add_liquidity_rate: u64,
        launchpad_fee: u64,
        transaction_fee_rate: u64,
        fudraising_fee_rate: u64,
    }

    struct LaunchAdmin has key {
        id: 0x2::object::UID,
    }

    struct LaunchManagerAdmin has key {
        id: 0x2::object::UID,
    }

    public fun get_add_liquidity_rate(arg0: &LaunchpadManagerConfig) : u64 {
        arg0.add_liquidity_rate
    }

    public fun get_launchpad_fee(arg0: &LaunchpadManagerConfig) : u64 {
        arg0.launchpad_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchpadManagerConfig{
            id                   : 0x2::object::new(arg0),
            add_liquidity_rate   : 50,
            launchpad_fee        : 1000,
            transaction_fee_rate : 0,
            fudraising_fee_rate  : 0,
        };
        0x2::transfer::share_object<LaunchpadManagerConfig>(v0);
        let v1 = LaunchManagerAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchManagerAdmin>(v1, 0x2::tx_context::sender(arg0));
        let v2 = LaunchAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchAdmin>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun set_add_liquidity_rate(arg0: &mut LaunchpadManagerConfig, arg1: &LaunchManagerAdmin, arg2: u64) {
        arg0.add_liquidity_rate = arg2;
    }

    public fun set_launch_admin(arg0: &LaunchManagerAdmin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchAdmin{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<LaunchAdmin>(v0, arg1);
    }

    public fun set_launchpad_fee(arg0: &mut LaunchpadManagerConfig, arg1: &LaunchManagerAdmin, arg2: u64) {
        arg0.launchpad_fee = arg2;
    }

    // decompiled from Move bytecode v6
}

