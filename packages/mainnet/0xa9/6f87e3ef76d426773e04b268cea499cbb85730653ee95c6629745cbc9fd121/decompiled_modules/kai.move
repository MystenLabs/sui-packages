module 0xa96f87e3ef76d426773e04b268cea499cbb85730653ee95c6629745cbc9fd121::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"KAI TRUMP", x"48692049e280996d204b6169205472756d702049206c6f766520676f6c662c2063727970746f20616e64206f6820796561204920616d20746865203437746820507265736964656e7473206772616e64646175676874657220f09f9295", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737519171338.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

