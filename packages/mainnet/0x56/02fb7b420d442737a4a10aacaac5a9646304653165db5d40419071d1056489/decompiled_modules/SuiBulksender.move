module 0x5602fb7b420d442737a4a10aacaac5a9646304653165db5d40419071d1056489::SuiBulksender {
    public entry fun bulksend<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        bulksendImpl<T0>(arg0, arg1, arg2, arg3);
    }

    fun bulksendImpl<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg1);
        assert!(v1 == 0x1::vector::length<u64>(&arg2), 0);
        while (v0 < v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

