module 0xbdaa4bfb21e54d4694b1c79b26729edaed5aae104d470c870cdc3be20f408131::terminus {
    struct TERMINUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERMINUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERMINUS>(arg0, 6, b"Terminus", b"TERMINUS", b"First City on Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731756529523.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERMINUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERMINUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

