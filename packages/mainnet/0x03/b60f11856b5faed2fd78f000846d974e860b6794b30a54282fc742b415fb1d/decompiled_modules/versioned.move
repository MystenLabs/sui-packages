module 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::versioned {
    struct Versioned has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    public fun check_version(arg0: &Versioned) {
        assert!(arg0.version == 1, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_version_deprecated());
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

    public fun upgrade(arg0: &mut Versioned, arg1: &0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::admin_cap::AdminCap) {
        assert!(arg0.version < 1, 0x3b60f11856b5faed2fd78f000846d974e860b6794b30a54282fc742b415fb1d::errors::err_invalid_version());
        arg0.version = 1;
    }

    public fun version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

