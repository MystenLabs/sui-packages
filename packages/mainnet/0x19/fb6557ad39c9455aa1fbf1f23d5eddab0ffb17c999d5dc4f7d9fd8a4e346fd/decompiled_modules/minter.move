module 0x6e3ae31a16362c563c0fef5293348d262646882a10c307f20f6be8577960f1ef::minter {
    public entry fun set_minter_cap<T0>(arg0: &0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::AdminCap, arg1: &mut 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::Minter<T0>, arg2: 0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::magma_token::MinterCap<T0>) {
        0x3abcdefce1a0ec1252237b69efc6dc3881325d543fceaad2e2f360a02d2f5bd9::minter::set_minter_cap<T0>(arg1, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

