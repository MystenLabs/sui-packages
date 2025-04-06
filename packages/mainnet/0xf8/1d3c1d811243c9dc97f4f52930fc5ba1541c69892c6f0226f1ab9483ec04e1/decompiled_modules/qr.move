module 0xf81d3c1d811243c9dc97f4f52930fc5ba1541c69892c6f0226f1ab9483ec04e1::qr {
    struct QR has drop {
        dummy_field: bool,
    }

    fun init(arg0: QR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QR>(arg0, 9, b"QR", b"QR COIN", b"QR COINS FOR COLLECTION AND TRADE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QR>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QR>>(v2, @0x9b2a60e7773bdefe3f66f5acb7855822fac796e96be5027551ece2936a434be3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QR>>(v1);
    }

    // decompiled from Move bytecode v6
}

