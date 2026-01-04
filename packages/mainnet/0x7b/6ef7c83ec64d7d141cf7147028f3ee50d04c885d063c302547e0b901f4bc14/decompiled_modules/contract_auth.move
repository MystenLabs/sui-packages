module 0x7b6ef7c83ec64d7d141cf7147028f3ee50d04c885d063c302547e0b901f4bc14::contract_auth {
    public fun assert_auth_type<T0>(arg0: &T0, arg1: vector<u8>) : address {
        let v0 = get_auth_address<T0>(arg1);
        if (0x1::option::is_none<address>(&v0)) {
            abort 13906834517940764673
        };
        *0x1::option::borrow<address>(&v0)
    }

    public fun auth_as<T0, T1: key>(arg0: &T0, arg1: vector<u8>, arg2: &T1) : address {
        let v0 = 0x1::type_name::get<T1>();
        assert!(assert_auth_type<T0>(arg0, arg1) == 0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::get_address(&v0)))), 13906834556595470337);
        0x2::object::id_address<T1>(arg2)
    }

    public fun get_auth_address<T0>(arg0: vector<u8>) : 0x1::option::Option<address> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::get_address(&v0));
        0x1::vector::append<u8>(&mut v1, b"::");
        0x1::vector::append<u8>(&mut v1, 0x1::ascii::into_bytes(0x1::type_name::get_module(&v0)));
        0x1::vector::append<u8>(&mut v1, b"::");
        0x1::vector::append<u8>(&mut v1, arg0);
        if (0x1::ascii::into_bytes(0x1::type_name::into_string(v0)) == v1) {
            0x1::option::some<address>(0x2::address::from_bytes(0x2::hex::decode(v1)))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun is_auth_type<T0>(arg0: vector<u8>) : bool {
        let v0 = get_auth_address<T0>(arg0);
        0x1::option::is_some<address>(&v0)
    }

    // decompiled from Move bytecode v6
}

