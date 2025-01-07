module 0x2f9140aa146e8421f128c21496093aa958dd3a9fa10e2b517855f4aa09f1a22d::wsr {
    struct WSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSR>(arg0, 6, b"WSR", b"Wasser", b"Water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3131_c0ddb58e12.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

