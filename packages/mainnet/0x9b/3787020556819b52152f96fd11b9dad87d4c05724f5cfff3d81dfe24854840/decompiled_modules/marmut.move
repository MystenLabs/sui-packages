module 0x9b3787020556819b52152f96fd11b9dad87d4c05724f5cfff3d81dfe24854840::marmut {
    struct MARMUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARMUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARMUT>(arg0, 9, b"MARMUT", b"Marmut", b"M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6cb61b13-8b78-43b2-b120-02bfa96b85cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARMUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARMUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

