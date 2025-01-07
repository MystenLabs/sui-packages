module 0x8848e9895a1d808e7f3450215645efe7c59bd39ef8cc735adda32bc0b403e152::bulk_send {
    public entry fun bulk_send<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        bulk_send_impl<T0>(arg0, arg1, arg2, arg3);
    }

    fun bulk_send_impl<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
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

