module 0x6d3705959f1abc42d0e28fdbaa233c94a19df347bc969222f647d1e3b59225de::ins {
    struct INS has drop {
        dummy_field: bool,
    }

    fun init(arg0: INS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INS>(arg0, 6, b"INS", b"inshallah", b"bought and say inshallah ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fw_EF_9u_HWAAARZJ_9_c524c258fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INS>>(v1);
    }

    // decompiled from Move bytecode v6
}

