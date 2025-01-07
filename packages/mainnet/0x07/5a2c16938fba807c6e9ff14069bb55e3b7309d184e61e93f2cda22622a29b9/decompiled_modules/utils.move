module 0x75a2c16938fba807c6e9ff14069bb55e3b7309d184e61e93f2cda22622a29b9::utils {
    struct Version has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct UTILS has drop {
        dummy_field: bool,
    }

    public fun check_version(arg0: &Version) {
        assert!(arg0.version == 0, 0);
    }

    public fun from_same_package<T0, T1>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        0x1::type_name::get_address(&v0) == 0x1::type_name::get_address(&v1)
    }

    public fun new_version(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<UTILS>(arg0), 1);
        let v0 = Version{
            id      : 0x2::object::new(arg1),
            version : 0,
        };
        0x2::transfer::public_share_object<Version>(v0);
    }

    public fun set_version(arg0: &0x2::package::Publisher, arg1: &mut Version, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<UTILS>(arg0), 1);
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

