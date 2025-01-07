module 0x3e891b0190bc5b6bef5984e2290bdcac75fbcf5141d868bc081ca1b68c4f5eb5::kirby {
    struct KIRBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBY>(arg0, 6, b"KIRBY", b"Kirby Sui", b"Learn the not-so-secret history of Nintendo's powerful pink puff, Kirby!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_13_08_17_4cf2248738.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

