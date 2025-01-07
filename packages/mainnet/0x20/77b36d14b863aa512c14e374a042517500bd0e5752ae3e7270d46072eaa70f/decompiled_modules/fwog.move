module 0x2077b36d14b863aa512c14e374a042517500bd0e5752ae3e7270d46072eaa70f::fwog {
    struct FWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWOG>(arg0, 6, b"FWOG", b"Sui Fwog", x"496e20746865206173686573206120636f6d6d756e69747920656d65726765642c2061206e65772066726f672c2061206d6f72652062617365642066726f672c20612046574f472e2046574f4720686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9dca3887_95e7_4b35_9a62_b2915240e446_1470a274f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

