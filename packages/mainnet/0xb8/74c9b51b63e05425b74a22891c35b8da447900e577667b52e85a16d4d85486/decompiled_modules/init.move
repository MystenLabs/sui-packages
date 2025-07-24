module 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::init {
    struct INIT has drop {
        dummy_field: bool,
    }

    struct InitCap has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    fun init(arg0: INIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = InitCap{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<INIT>(arg0, arg1),
        };
        0x2::transfer::transfer<InitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize(arg0: InitCap, arg1: 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::system_object_cap::SystemObjectCap, arg2: 0x2::package::UpgradeCap, arg3: 0x2::package::UpgradeCap, arg4: 0x2::coin::TreasuryCap<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u16, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u16, arg15: 0x1::string::String, arg16: &mut 0x2::tx_context::TxContext) : 0x9e1e9f8e4e51ee2421a8e7c0c6ab3ef27c337025d15333461b72b1b813c44175::protocol_cap::ProtocolCap {
        let InitCap {
            id        : v0,
            publisher : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = 0x2::package::upgrade_package(&arg2);
        let v3 = 0x2::package::upgrade_package(&arg3);
        let v4 = 0x1::type_name::get<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>();
        assert!(0x1::type_name::get_address(&v4) == 0x2::address::to_ascii_string(0x2::object::id_to_address(&v2)), 1);
        let v5 = 0x1::type_name::get<InitCap>();
        assert!(0x1::type_name::get_address(&v5) == 0x2::address::to_ascii_string(0x2::object::id_to_address(&v3)), 1);
        let v6 = 0x1::vector::empty<0x2::package::UpgradeCap>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x2::package::UpgradeCap>(v7, arg2);
        0x1::vector::push_back<0x2::package::UpgradeCap>(v7, arg3);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::display::create(v1, arg15, arg16);
        0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::system::create(v3, arg1, v6, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::validator_set::new(arg11, arg12, arg13, arg12, arg14, arg16), arg5, arg6, arg7, arg8, 0xb874c9b51b63e05425b74a22891c35b8da447900e577667b52e85a16d4d85486::protocol_treasury::create(arg4, arg9, arg10, arg16), arg16)
    }

    // decompiled from Move bytecode v6
}

