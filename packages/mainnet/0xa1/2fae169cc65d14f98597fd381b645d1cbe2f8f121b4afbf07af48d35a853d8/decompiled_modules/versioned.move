module 0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::versioned {
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0xa12fae169cc65d14f98597fd381b645d1cbe2f8f121b4afbf07af48d35a853d8::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 13906834324667432964);
        arg0.version = 1;
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

