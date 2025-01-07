module 0x3de1a995a0c27c025e70d06a189dd0bd02cda44c37154771186530daf57404c::wrd {
    struct WRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WRD>(arg0, 9, b"WRD", b"world", b"The world in you and you in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4dddc50-65ee-49c4-925f-73bbda8b7bc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

