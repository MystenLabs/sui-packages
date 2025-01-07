module 0x9c7c2975b2ec036d811be153baa35a1b8a5b9c9871aef661af4b04ddba25ffff::catrix {
    struct CATRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATRIX>(arg0, 6, b"CATRIX", b"CAT IN THE MATRIX", b"The only cat in the matrix of sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jpg_b05bd50fc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATRIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATRIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

