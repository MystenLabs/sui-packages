module 0x62fcd22d12235050533402388552688e3a861ce963194ad0115d92de82d1ffc6::cbull {
    struct CBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBULL>(arg0, 6, b"CBULL", b"Chill Bull", b"$CBULL the most bullish meme coin on  sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CB_4_1_6b97e88fb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

