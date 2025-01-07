module 0x71329cdbdbf1b0cfd750a646dd44084bb270fbdc960817938341f67ad7390e60::qrd {
    struct QRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRD>(arg0, 6, b"QRD", b"QRDOG", b"JUST SCANN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QR_a1553104ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

