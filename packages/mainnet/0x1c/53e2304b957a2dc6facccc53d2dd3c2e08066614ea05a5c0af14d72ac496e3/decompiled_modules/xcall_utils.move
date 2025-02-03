module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils {
    public fun address_from_hex_string(arg0: &0x1::string::String) : address {
        let v0 = arg0;
        if (0x1::string::length(arg0) == 66) {
            let v1 = 0x1::string::sub_string(arg0, 2, 66);
            v0 = &v1;
        };
        let v2 = 0x2::bcs::new(0x2::hex::decode(*0x1::string::bytes(v0)));
        0x2::bcs::peel_address(&mut v2)
    }

    public fun address_to_hex_string(arg0: &address) : 0x1::string::String {
        0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(arg0)))
    }

    public fun are_equal<T0>(arg0: &vector<T0>, arg1: &vector<T0>) : bool {
        if (0x1::vector::length<T0>(arg0) != 0x1::vector::length<T0>(arg1)) {
            false
        } else {
            let v1 = 0;
            while (v1 < 0x1::vector::length<T0>(arg0)) {
                if (0x1::vector::borrow<T0>(arg0, v1) != 0x1::vector::borrow<T0>(arg1, v1)) {
                    return false
                };
                v1 = v1 + 1;
            };
            true
        }
    }

    public fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun format_sui_address(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        if (0x1::string::sub_string(&v0, 0, 2) == 0x1::string::utf8(b"0x")) {
            v0 = 0x1::string::sub_string(arg0, 2, 0x1::string::length(arg0));
        };
        v0
    }

    public fun get_or_default<T0: copy, T1: copy + drop>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &T0, arg2: T1) : T1 {
        if (0x2::vec_map::contains<T0, T1>(arg0, arg1)) {
            *0x2::vec_map::get<T0, T1>(arg0, arg1)
        } else {
            arg2
        }
    }

    public fun id_from_hex_string(arg0: &0x1::string::String) : 0x2::object::ID {
        let v0 = format_sui_address(arg0);
        0x2::object::id_from_bytes(0x2::hex::decode(*0x1::string::bytes(&v0)))
    }

    public fun id_to_hex_string(arg0: &0x2::object::ID) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(arg0))));
        v0
    }

    // decompiled from Move bytecode v6
}

