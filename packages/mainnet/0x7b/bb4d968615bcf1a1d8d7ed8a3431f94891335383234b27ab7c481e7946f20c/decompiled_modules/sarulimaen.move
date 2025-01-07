module 0x7bbb4d968615bcf1a1d8d7ed8a3431f94891335383234b27ab7c481e7946f20c::sarulimaen {
    struct SARULIMAEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SARULIMAEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SARULIMAEN>(arg0, 9, b"SARULIMAEN", b"156", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f10cb1dd-1a8e-4d3d-b327-b8da69949af7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SARULIMAEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SARULIMAEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

