module 0x9ab137b460e23cafd5044236ff6f4fe5f95390e25d95273863a418c9583a471::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMI>(arg0, 6, b"Ngmi", b"NGMI x Texas", b"Ngmi is the Texas owner, he feed his puppy in exchange of a cock suck ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_2_3ff261e74d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

