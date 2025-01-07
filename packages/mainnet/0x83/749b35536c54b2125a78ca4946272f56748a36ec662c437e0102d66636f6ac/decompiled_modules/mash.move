module 0x83749b35536c54b2125a78ca4946272f56748a36ec662c437e0102d66636f6ac::mash {
    struct MASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASH>(arg0, 9, b"MASH", b"mushroom", b"Mushrooms are the essence of life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb7cd41f-48d5-4401-8da1-eb755725f196.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

