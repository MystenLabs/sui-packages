module 0x5f15dd34519fe4c8f636ae4580a5076d1b194290a6f2b091df43d68d0b6f1a1b::bimpson {
    struct BIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIMPSON>(arg0, 6, b"Bimpson", b"Simpson", b"Bart's most prominent and popular character traits are his mischievousness, rebelliousness and disrespect for authority. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_QD_Dnq_F0_400x400_44e7f3182d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

