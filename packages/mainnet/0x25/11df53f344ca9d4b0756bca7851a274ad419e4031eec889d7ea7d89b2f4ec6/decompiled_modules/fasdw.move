module 0x2511df53f344ca9d4b0756bca7851a274ad419e4031eec889d7ea7d89b2f4ec6::fasdw {
    struct FASDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASDW>(arg0, 6, b"FASDW", b"asdf", b"qasdfawef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1cd5a4ab_c6f1_4f7e_a579_77cea55efe28_7dae78c4bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASDW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FASDW>>(v1);
    }

    // decompiled from Move bytecode v6
}

