module 0x6e3ae31a16362c563c0fef5293348d262646882a10c307f20f6be8577960f1ef::magma_token {
    public entry fun burn<T0>(arg0: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token::MinterCap<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token::MinterCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token::mint<T0>(arg0, arg1, arg2, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

