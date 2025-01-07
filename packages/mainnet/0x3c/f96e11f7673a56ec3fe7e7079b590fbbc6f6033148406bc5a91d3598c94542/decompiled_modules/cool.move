module 0x3cf96e11f7673a56ec3fe7e7079b590fbbc6f6033148406bc5a91d3598c94542::cool {
    struct COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOL>(arg0, 9, b"COOL", b"GIA", b"The world is for digital currency So invest wisely Together! Because \"GIA\" will be a part of it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/53060b8f-4bf4-4993-80a4-dd6b97b9b204-1000504028.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

