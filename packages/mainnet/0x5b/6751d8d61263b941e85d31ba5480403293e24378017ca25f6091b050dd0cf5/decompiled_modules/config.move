module 0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        keeper: address,
        fee_bps: u64,
        fee_wallet: address,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        keeper: address,
    }

    public fun assert_is_keeper(arg0: &KeeperCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.keeper == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1.keeper == 0x2::tx_context::sender(arg2), 1);
    }

    public fun assert_not_keeper(arg0: address, arg1: &Config) {
        assert!(arg1.keeper != arg0, 2);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun assign_keeper(arg0: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::app::AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        arg1.keeper = arg2;
        let v0 = KeeperCap{
            id     : 0x2::object::new(arg3),
            keeper : arg2,
        };
        0x2::transfer::transfer<KeeperCap>(v0, arg2);
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_wallet(arg0: &Config) : address {
        arg0.fee_wallet
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(&arg0), 3);
        let v0 = Config{
            id         : 0x2::object::new(arg1),
            version    : 1,
            keeper     : 0x2::tx_context::sender(arg1),
            fee_bps    : 25,
            fee_wallet : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun set_fee_bps(arg0: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::app::AdminCap, arg1: &mut Config, arg2: u64) {
        assert_version(arg1);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_wallet(arg0: &0x5b6751d8d61263b941e85d31ba5480403293e24378017ca25f6091b050dd0cf5::app::AdminCap, arg1: &mut Config, arg2: address) {
        assert_version(arg1);
        arg1.fee_wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

