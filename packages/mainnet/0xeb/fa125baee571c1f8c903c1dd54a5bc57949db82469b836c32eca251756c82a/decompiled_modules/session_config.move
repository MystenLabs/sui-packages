module 0xebfa125baee571c1f8c903c1dd54a5bc57949db82469b836c32eca251756c82a::session_config {
    struct SessionsConfig has key {
        id: 0x2::object::UID,
        version_watermark: u64,
    }

    struct SessionsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun assert_version(arg0: &SessionsConfig) {
        assert!(1 >= arg0.version_watermark, 0);
    }

    public fun bump_version_watermark(arg0: &mut SessionsConfig, arg1: &SessionsAdminCap) {
        let v0 = 1;
        assert!(v0 > arg0.version_watermark, 1);
        arg0.version_watermark = v0;
    }

    fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, SessionsAdminCap) {
        let v0 = SessionsConfig{
            id                : 0x2::object::new(arg0),
            version_watermark : 1,
        };
        0x2::transfer::share_object<SessionsConfig>(v0);
        let v1 = SessionsAdminCap{id: 0x2::object::new(arg0)};
        (id(&v0), v1)
    }

    public fun id(arg0: &SessionsConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = create_and_share(arg0);
        0x2::transfer::public_transfer<SessionsAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun version_watermark(arg0: &SessionsConfig) : u64 {
        arg0.version_watermark
    }

    // decompiled from Move bytecode v7
}

