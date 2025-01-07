module 0xd09da1bc8808af38a6ddf1d5fad1ec00e321f459ba1ba8e1e2e2e6e9cf89a4db::nuko {
    struct NUKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUKO>(arg0, 6, b"NUKO", b"NUKO SUI", b"On a mission to sui the next billion normies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_23_23_12_23_722214389b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

