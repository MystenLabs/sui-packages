module 0xe32c2cdb5b4bcfc39d32645ba8b9a5cc967b2e0fe56b2b8e4bc7691695877e19::dogeking {
    struct DOGEKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEKING>(arg0, 6, b"DogeKing", b"DOGECOIN KING", b"DogeKing is the King of Meme coin that appeared to regain the prestige and trust of the true meme world, was strongly shilled by Elonmusk and built a golden empire starting from 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/db9238be-ce0d-46e5-9975-4cad39102b6e.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEKING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEKING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

