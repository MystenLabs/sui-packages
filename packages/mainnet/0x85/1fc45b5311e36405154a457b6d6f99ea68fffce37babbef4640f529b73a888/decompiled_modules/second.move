module 0x120bf413918ad846b52f92e94e2b7cd77303530735eaeb8bf2c9c035aa95af05::second {
    struct SECOND has drop {
        dummy_field: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun get_version(arg0: &Config) : u64 {
        arg0.version
    }

    fun init(arg0: SECOND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg1),
            version : 4,
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    public fun migrate(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version != 4, 1001);
        arg0.version = 4;
    }

    public fun update_version(arg0: &mut Config, arg1: u64) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

