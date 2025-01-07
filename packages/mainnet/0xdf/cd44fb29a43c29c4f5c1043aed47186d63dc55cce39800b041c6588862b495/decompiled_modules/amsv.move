module 0xdfcd44fb29a43c29c4f5c1043aed47186d63dc55cce39800b041c6588862b495::amsv {
    struct AMSV has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMSV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMSV>(arg0, 9, b"AMSV", b"lisiy", b"My fan token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b80b7002-59bf-4280-be30-e5392f2f978c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMSV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMSV>>(v1);
    }

    // decompiled from Move bytecode v6
}

