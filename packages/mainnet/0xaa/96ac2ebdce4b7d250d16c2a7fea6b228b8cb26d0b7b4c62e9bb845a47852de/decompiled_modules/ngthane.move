module 0xaa96ac2ebdce4b7d250d16c2a7fea6b228b8cb26d0b7b4c62e9bb845a47852de::ngthane {
    struct NGTHANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGTHANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGTHANE>(arg0, 9, b"NGTHANE", b"NQT", b"Gastradefre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f181c3d-d4e8-4b17-b465-a4cb98eaec74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGTHANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGTHANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

