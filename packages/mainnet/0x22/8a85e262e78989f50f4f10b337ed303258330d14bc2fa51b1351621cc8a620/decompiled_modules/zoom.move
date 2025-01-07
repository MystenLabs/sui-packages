module 0x228a85e262e78989f50f4f10b337ed303258330d14bc2fa51b1351621cc8a620::zoom {
    struct ZOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOOM>(arg0, 9, b"ZOOM", b"ZoomerCoin", b"ZoomerCoin is a meme token designed specifically for the younger generation, especially the energetic and dynamic Gen Z. With a modern internet meme theme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0b0ec6cc-2a77-4e5e-b78f-aa304ce13294.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

