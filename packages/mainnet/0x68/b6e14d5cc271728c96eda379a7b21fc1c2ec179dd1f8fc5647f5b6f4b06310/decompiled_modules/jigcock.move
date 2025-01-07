module 0x68b6e14d5cc271728c96eda379a7b21fc1c2ec179dd1f8fc5647f5b6f4b06310::jigcock {
    struct JIGCOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGCOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGCOCK>(arg0, 6, b"JIGCOCK", b"Jig Cock", b"The name is HELLO. HELLO is a Oscar awarded Cocks and he open a dancing class to teach us Dancing. Cocks are Jiging", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046370_e7e399cc6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGCOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIGCOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

