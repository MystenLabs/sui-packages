module 0x95c81d2a0aedfcbc2548bd99d250ba112425f0ff84e0e726eb66db341fe4c1a9::inukami {
    struct INUKAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INUKAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUKAMI>(arg0, 6, b"INUKAMI", b"INU KAMI ON SUI", b"Witness the rise of INU KAMI! It is a crown jewel, waiting for you to claim your share of the kingdoms wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1x1_1_150x150_e68c80e7e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUKAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INUKAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

