module 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::coin_converter {
    public fun cast<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::bag::new(arg1);
        let v1 = 0x1::string::utf8(b"tmp");
        0x2::bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v0, v1, arg0);
        0x2::bag::destroy_empty(v0);
        0x2::bag::remove<0x1::string::String, 0x2::coin::Coin<T1>>(&mut v0, v1)
    }

    // decompiled from Move bytecode v6
}

