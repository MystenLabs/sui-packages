module 0xf85f1c173a0ade8c1fbd5b6d4519eedc853fd305c2c7bddf0063780a9b082203::sden {
    struct SDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDEN>(arg0, 6, b"SDEN", b"SUIDEN", b"Home to the largest population of gay people. Join the gay side of sui and become one of us!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Flag_of_Sweden_svg_70cefcd735.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

