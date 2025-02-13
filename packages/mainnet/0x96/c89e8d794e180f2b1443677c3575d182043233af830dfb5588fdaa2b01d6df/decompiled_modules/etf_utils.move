module 0x96c89e8d794e180f2b1443677c3575d182043233af830dfb5588fdaa2b01d6df::etf_utils {
    public fun get_total_weight(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_coin_type_in_fund(arg0: vector<0x1::type_name::TypeName>, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(&arg0, v0) == &arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun take_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: 0x1::option::Option<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0x2::coin::value<T0>(arg0) * arg3 / 1000;
        if (v0 == 0) {
            return
        };
        if (0x1::option::is_some<address>(&arg2)) {
            if (v0 / 3 == 0) {
                return
            };
            let v1 = 0x2::coin::split<T0>(arg0, v0, arg4);
            let v2 = 0x1::option::borrow<address>(&arg2);
            let v3 = 0x2::coin::value<T0>(&v1) / 3;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v3, arg4), *v2);
            0x96c89e8d794e180f2b1443677c3575d182043233af830dfb5588fdaa2b01d6df::events::emit_fee_event(arg1, *v2, v0, v3, 0x1::type_name::get<T0>());
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg4), arg1);
            0x96c89e8d794e180f2b1443677c3575d182043233af830dfb5588fdaa2b01d6df::events::emit_fee_event(arg1, arg1, v0, 0, 0x1::type_name::get<T0>());
        };
    }

    // decompiled from Move bytecode v6
}

