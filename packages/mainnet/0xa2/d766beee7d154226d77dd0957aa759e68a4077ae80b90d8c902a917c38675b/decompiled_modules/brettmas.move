module 0xa2d766beee7d154226d77dd0957aa759e68a4077ae80b90d8c902a917c38675b::brettmas {
    struct BRETTMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETTMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETTMAS>(arg0, 6, b"BRETTMAS", b"BRETTMAS SUI", b"Meme Coin Of The Year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6484_1c752cb871.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETTMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETTMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

