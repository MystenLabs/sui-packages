module 0x3b4fb7a43b0e435ff756da6682aeda68b5df7363034a97f6a9246acf376f6a1b::jvance {
    struct JVANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JVANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JVANCE>(arg0, 6, b"JVANCE", b"JD VANCE", b"JDJDJDVANCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3d8a5d8a_880e_41ba_8a2e_244154f4ae84_1535adedaf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JVANCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JVANCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

