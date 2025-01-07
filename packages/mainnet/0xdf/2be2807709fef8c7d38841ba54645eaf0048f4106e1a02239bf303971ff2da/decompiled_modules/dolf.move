module 0xdf2be2807709fef8c7d38841ba54645eaf0048f4106e1a02239bf303971ff2da::dolf {
    struct DOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLF>(arg0, 6, b"DOLF", b"Dolf", b"DOLF is a young and charming dolphin that confidently surfs through the chaos of meme coins, becoming the ultimate icon of the SUI ocean!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Resized_Dolf_b343998bd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

