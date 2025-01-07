module 0xaa2febee8d47f468ae06c4d895c2041d341f1fd195cd8286b37b91df8b63e5d8::belugat {
    struct BELUGAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGAT>(arg0, 9, b"BELUGAT", b"BELUGA", b"BELUGA TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24f0b41e-c11a-4d20-ba43-c6a1dfda4437.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELUGAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

