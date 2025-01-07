module 0x18e4d7665d71e1738315f2ece9943e837388bbf8818c13581ff2ec7ebfe80867::tits {
    struct TITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITS, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<TITS>(arg0, 8125335792039985325, b"We Love Tits", b"TITS", b"We Love Tits - Big or small we love them all!, this is the continuation of success story of TITS on Solana, and not linked with them in any manner, it is just a motivation to release it on SUI, if they want, we will transfer the ownership to actual team.", b"https://images.hop.ag/ipfs/QmdVfJFMpw9ZTfcD2xJ4X5sYWeBzYjJjMQCnMmFLhPmVuy", 0x1::string::utf8(b"https://twitter.com/weloveetits"), 0x1::string::utf8(b"https://welovetits.com/"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

