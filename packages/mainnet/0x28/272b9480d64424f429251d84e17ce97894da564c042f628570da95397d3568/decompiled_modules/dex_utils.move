module 0x28272b9480d64424f429251d84e17ce97894da564c042f628570da95397d3568::dex_utils {
    public fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 100000) as u64)
    }

    public fun check_amounts<T0, T1>(arg0: &0x2::coin::Coin<T0>, arg1: &0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(arg0) > 0 || 0x2::coin::value<T1>(arg1) > 0, 1);
        assert!(0x2::coin::value<T0>(arg0) == 0 || 0x2::coin::value<T1>(arg1) == 0, 2);
    }

    public fun is_base<T0>() : bool {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v0);
        let v2 = b"0x2::sui::SUI";
        if (0x1::vector::length<u8>(&v1) != 0x1::vector::length<u8>(&v2)) {
            return false
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&v2)) {
            if (*0x1::vector::borrow<u8>(&v1, v3) != *0x1::vector::borrow<u8>(&v2, v3)) {
                return false
            };
            v3 = v3 + 1;
        };
        true
    }

    public fun not_base<T0>() {
        assert!(!is_base<T0>(), 0);
    }

    // decompiled from Move bytecode v6
}

