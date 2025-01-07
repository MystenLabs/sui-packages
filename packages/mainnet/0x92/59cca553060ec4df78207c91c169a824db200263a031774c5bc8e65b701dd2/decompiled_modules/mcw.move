module 0x9259cca553060ec4df78207c91c169a824db200263a031774c5bc8e65b701dd2::mcw {
    struct MCW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MCW>(arg0, 6, b"MCW", b"My Crypto Wallet", b"My finance situation right now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hungryweara_pfp_1_10fb07b980.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

