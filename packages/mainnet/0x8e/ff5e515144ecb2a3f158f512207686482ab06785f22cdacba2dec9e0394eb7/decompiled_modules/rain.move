module 0x8eff5e515144ecb2a3f158f512207686482ab06785f22cdacba2dec9e0394eb7::rain {
    public fun rain_split<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = v1 * arg4 / 10000;
        assert!(v2 * 2 < v1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v2, arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v2, arg5), arg3);
        let v3 = 0x2::coin::value<T0>(&arg0);
        let v4 = v3 / v0;
        assert!(v4 > 0, 2);
        let v5 = 0;
        while (v5 < v0) {
            let v6 = if (v5 < v3 % v0) {
                1
            } else {
                0
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, v4 + v6, arg5), *0x1::vector::borrow<address>(&arg1, v5));
            v5 = v5 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

