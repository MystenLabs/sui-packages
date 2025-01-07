module 0xfc75cbf7ad7072b916107e775281eb3e2ebedf55b04e8f1f06fb3de8c297cf06::suiwifhat {
    struct SUIWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIFHAT>(arg0, 6, b"Suiwifhat", b"SuiWifHat", b"The Suiwifhat logo cleverly blends the whimsical charm of the Dogwifhat meme culture with the modern elegance of the Sui blockchain. Featuring a playful twist, the logo incorporates the iconic Dogwifhat hat atop the sleek Sui emblem, symbolizing a fusion of meme-inspired fun and cutting-edge technology. This unique design captures the essence of Suiwifhat: a meme coin that merges humor with the innovation of the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suiwifhat_51d7ae3f80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

