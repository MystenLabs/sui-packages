module 0xaf2c6d868d0ec21555ab83e76c23b2b6cffdcdd2072b3f62a0af8a81fba14f8a::mavol {
    struct MAVOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAVOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAVOL>(arg0, 9, b"MAVOL", b"MaVol", b"Wolf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eaefe5f5-cdd9-4dcf-b4b3-7337dd51e205.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAVOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAVOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

