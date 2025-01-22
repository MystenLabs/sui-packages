module 0x873cdddafb3aaa1ff3359cf986ae7f7ccc053fd81a23dac93db5fdfd2a1951c1::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"KAI TRUMP by SuiAI", x"48692049e280996d204b6169205472756d702049206c6f766520676f6c662c2063727970746f20616e64206f6820796561204920616d20746865203437746820507265736964656e7473206772616e64646175676874657220f09f92952e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737519171338_b5b1813ed4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

