module 0xd88ebdabeaead893d6ce24259bf596627ff4d209b9e1541c2eb7997fa90651d2::api {
    public fun take_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 500, 1);
        if (arg2 == 0) {
            return
        };
        let v0 = (((0x2::coin::value<T0>(arg0) as u128) * (arg2 as u128) / 10000) as u64);
        let v1 = 0x2::coin::split<T0>(arg0, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, v0 / 2, arg3), @0xa89611f02060bad390103e783a62c88725b47059e6460cf0d2f3ca32e2559641);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, arg1);
    }

    public fun take_commission_api<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        take_commission_partner<T0>(arg0, @0xa89611f02060bad390103e783a62c88725b47059e6460cf0d2f3ca32e2559641, arg1, arg2);
    }

    public fun take_commission_partner<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 500, 1);
        if (arg2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, (((0x2::coin::value<T0>(arg0) as u128) * (arg2 as u128) / 10000) as u64), arg3), arg1);
    }

    // decompiled from Move bytecode v6
}

