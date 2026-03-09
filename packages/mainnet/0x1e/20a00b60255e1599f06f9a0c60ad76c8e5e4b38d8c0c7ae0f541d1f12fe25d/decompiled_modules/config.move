module 0xa0b5342e44a869019b627c7d49208064893e5a69e28ae79e54a660a728269ba7::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058295800332289);
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339719237566467);
        let v0 = Config{
            id           : 0x2::object::new(arg1),
            version      : 1,
            extra_fields : 0x2::bag::new(arg1),
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    // decompiled from Move bytecode v6
}

