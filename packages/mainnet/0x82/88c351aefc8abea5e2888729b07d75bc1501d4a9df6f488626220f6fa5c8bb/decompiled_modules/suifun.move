module 0x8288c351aefc8abea5e2888729b07d75bc1501d4a9df6f488626220f6fa5c8bb::suifun {
    struct SUIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x7252ceff39b4eec3ad16d67014a532fb31f4907e1a61ab6a6f0cea64700e711f::connector_v3::new<SUIFUN>(arg0, 630337348, b"SUIFUN ", b"suifun", b"suifun's first token ever", b"https://ipfs.io/ipfs/bafkreidbqmdn66jz4u5y3hysa3g3zofwvzioswhbktjun4ovxxbndfsu6a", 0x1::string::utf8(b"https://twitter.com"), 0x1::string::utf8(b"https://mad.com"), 0x1::string::utf8(b"https://telegram.com"), arg1);
    }

    // decompiled from Move bytecode v6
}

