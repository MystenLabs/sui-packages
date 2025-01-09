module 0xe11f6f9061aeeed400516f32389bf9029024429ce1fcc6f673c6d7ec41154ba4::disperse {
    public entry fun disperse<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            transfer_coin<T0>(arg0, *0x1::vector::borrow<u64>(&arg1, v0), *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    fun transfer_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::coin::balance_mut<T0>(arg0), arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

