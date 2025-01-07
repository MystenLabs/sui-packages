module 0xda905d9f53751e261243e1d3c2edf177582189e03b50f80a63853eedb1134572::zid {
    struct ZID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZID>(arg0, 9, b"ZID", b"YAZID", b"ZID is meme token inspiring by a real figure with name Hilmi Yazid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ad1988f-9b8e-4cc7-8a3d-764a172812d8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZID>>(v1);
    }

    // decompiled from Move bytecode v6
}

