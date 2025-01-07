module 0xac43f5ea8b811fa39c20ad0e6e55203c4f93ff42809eab24838d7cf5ae6f5294::semangat {
    struct SEMANGAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEMANGAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEMANGAT>(arg0, 9, b"SEMANGAT", b"Semangat", b"Semangat harus semangat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea5b2d72-f112-46a7-896c-296b2365173c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEMANGAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEMANGAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

