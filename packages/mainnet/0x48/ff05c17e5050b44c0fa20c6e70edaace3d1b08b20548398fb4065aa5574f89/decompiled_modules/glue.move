module 0x48ff05c17e5050b44c0fa20c6e70edaace3d1b08b20548398fb4065aa5574f89::glue {
    struct GLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUE>(arg0, 6, b"GLUE", b"GLUE EATER", b"@GLUE EATER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F6_S3_Gb_Jn_400x400_46f1ce44ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

