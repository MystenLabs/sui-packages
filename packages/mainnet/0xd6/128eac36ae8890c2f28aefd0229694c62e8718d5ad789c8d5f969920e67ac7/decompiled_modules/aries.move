module 0xd6128eac36ae8890c2f28aefd0229694c62e8718d5ad789c8d5f969920e67ac7::aries {
    struct ARIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARIES>(arg0, 6, b"ARIES", b"ARIES SUI", b"the new alpha from sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_29_14_12_08_2f1aa9818e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

