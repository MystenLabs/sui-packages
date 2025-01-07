module 0x8912a0f2b7ae3f1f089c17d0b58313168211ab3fe6cd85db3328b66a21c2c41::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 6, b"JERRY", b"JERRY ON SUI", b"$JERRY is known to be one of the most cultural icons #MEMECOIN on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jery_1640e42016.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

