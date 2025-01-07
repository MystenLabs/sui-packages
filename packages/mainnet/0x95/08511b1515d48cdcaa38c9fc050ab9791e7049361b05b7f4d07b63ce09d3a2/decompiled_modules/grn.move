module 0x9508511b1515d48cdcaa38c9fc050ab9791e7049361b05b7f4d07b63ce09d3a2::grn {
    struct GRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRN>(arg0, 9, b"GRN", b"Grandfathe", b"The best grandfather", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/27f87ad3-80f1-407f-a6de-f2e0b7cf4497.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

