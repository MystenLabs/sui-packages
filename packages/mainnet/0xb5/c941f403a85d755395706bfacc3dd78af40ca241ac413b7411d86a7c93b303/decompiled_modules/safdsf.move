module 0xb5c941f403a85d755395706bfacc3dd78af40ca241ac413b7411d86a7c93b303::safdsf {
    struct SAFDSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAFDSF, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<SAFDSF>(arg0, 57859542, b"ASDFSD", b"safdsf", b"fsdfsdfdsf", b"https://ipfs.io/ipfs/bafkreidbqmdn66jz4u5y3hysa3g3zofwvzioswhbktjun4ovxxbndfsu6a", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

