module 0x3be32ed3b889f6eece39b229336b688c0f16dbfb905e78939e46e4abc7a91e1::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 13906834294602530818);
    }

    public fun get_version(arg0: &Versioned) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Versioned{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_share_object<Versioned>(v0);
    }

    public fun upgrade(arg0: &mut Versioned, arg1: &0x3be32ed3b889f6eece39b229336b688c0f16dbfb905e78939e46e4abc7a91e1::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834324667432964);
        arg0.version = 1;
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

