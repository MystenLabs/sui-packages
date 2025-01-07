module 0xece4138b27f13a78d7dda4942f4847f012d1ae0282dcec8dde9f6e07176def25::mhippo {
    struct MHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHIPPO>(arg0, 6, b"MHIPPO", b"Mother Hippo", b"Mother Hippo Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_02_31_04_72be322ff3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

