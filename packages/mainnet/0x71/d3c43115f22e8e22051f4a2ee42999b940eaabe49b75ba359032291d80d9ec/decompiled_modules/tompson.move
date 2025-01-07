module 0x71d3c43115f22e8e22051f4a2ee42999b940eaabe49b75ba359032291d80d9ec::tompson {
    struct TOMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMPSON>(arg0, 9, b"TOMPSON", b"Thomas", b"Thomas is a little red cat who loves to sleep and is very lazy. He has a fluffy tail and big eyes, you can have fun with him, but he chooses, not you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f68c5fd-3a7d-429b-926f-aaf8e6c40ce8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

