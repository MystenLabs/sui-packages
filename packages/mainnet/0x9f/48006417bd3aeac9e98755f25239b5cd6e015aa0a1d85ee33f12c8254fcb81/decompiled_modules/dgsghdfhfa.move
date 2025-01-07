module 0x9f48006417bd3aeac9e98755f25239b5cd6e015aa0a1d85ee33f12c8254fcb81::dgsghdfhfa {
    struct DGSGHDFHFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGHDFHFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGHDFHFA>(arg0, 9, b"DGSGHDFHFA", b"SGfhhfdh", b"GSGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c6c0866-7747-4529-bf00-e390677cb11e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGHDFHFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGSGHDFHFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

