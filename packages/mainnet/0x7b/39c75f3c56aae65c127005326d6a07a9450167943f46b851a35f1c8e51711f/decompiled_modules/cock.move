module 0x7b39c75f3c56aae65c127005326d6a07a9450167943f46b851a35f1c8e51711f::cock {
    struct COCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCK>(arg0, 6, b"Cock", b"GameCock", b"The first chicken ok Sui is a Game Cock send the Cock. 1 Cock = 1 Cock ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6682_b2de6d2626.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

