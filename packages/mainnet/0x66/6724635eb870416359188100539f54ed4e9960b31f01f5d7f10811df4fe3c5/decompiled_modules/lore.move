module 0x666724635eb870416359188100539f54ed4e9960b31f01f5d7f10811df4fe3c5::lore {
    struct LORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORE>(arg0, 6, b"LORE", b"delorean", b"from the future with love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4ae13f8bc7ac1ed3f5f9a24cc3ea875f_ad15fd2374.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

