module 0x85588ad4fe5ac6ce8c803b10ec6ecd177a7dbd8794e26740a3af1c99c49fce33::qr {
    struct QR has drop {
        dummy_field: bool,
    }

    fun init(arg0: QR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QR>(arg0, 6, b"QR", b"QR CODE", b"Scan me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033121_911815c249.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QR>>(v1);
    }

    // decompiled from Move bytecode v6
}

