module 0x264eb81a11676eff01438328600533eb2b11e9561ad20c268b63a4b4dad4e2ac::keka {
    struct KEKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKA>(arg0, 6, b"KEKA", b"KEKA ON SUI", b"KEKA is more than a cryptocurrency; is a symbol of innovation and community in a constantly evolving digital world. Inspired by futuristic spirit and advanced technology, KEKA combines security, sustainability and accessibility to revolutionize the w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735851800476.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

