module 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::coin_converter {
    public fun cast<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::bag::new(arg1);
        let v1 = 0x1::string::utf8(b"tmp");
        0x2::bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut v0, v1, arg0);
        0x2::bag::destroy_empty(v0);
        0x2::bag::remove<0x1::string::String, 0x2::coin::Coin<T1>>(&mut v0, v1)
    }

    // decompiled from Move bytecode v6
}

