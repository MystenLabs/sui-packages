module 0x3768d3cbe1ef7e098db595b6bc5d9172be020a1a519a8dc120be9ecbf1e29e52::catgf {
    struct CATGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATGF>(arg0, 6, b"CATGF", b"CAT GIRLFRIEND AI", b"CAT GIRLFRIEND AI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5102_c1bd1325b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

