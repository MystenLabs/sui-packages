module 0x86049c5a677b65d26ead2fd35d9f569c35bd3d167ab47467a0d4acccc30132e6::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"SWOG", b"SUIWOG", x"496e20746865206173686573206120636f6d6d756e69747920656d65726765642c2061206e657720666c6f672c2061206d6f726520626173656420666c6f672c20612053574f470a53574f4720686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FOG_8c0169d27a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

