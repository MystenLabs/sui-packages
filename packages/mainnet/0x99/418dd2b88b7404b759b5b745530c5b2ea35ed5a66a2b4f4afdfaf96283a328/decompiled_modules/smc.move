module 0x99418dd2b88b7404b759b5b745530c5b2ea35ed5a66a2b4f4afdfaf96283a328::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SMC>(arg0, 6, b"SMC", b"Sui Meme Cat", b"This memecoin is completely 100% just for fun coin No Twitter, No Website, No Telegram. It's up to you whenever you invest on this coin and help this one to complete the 100% Bonding Curve. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/e83fe73a_6ab2_46e9_abe1_99a08f1a9274_f3c037927c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

