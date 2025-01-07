module 0x6b4a84a96f54cda82e797ec545be052f2926a2f1a9750710ec3c50255278af69::lambo {
    struct LAMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMBO>(arg0, 6, b"LAMBO", b"Sui Lambo", b" Hi, I'm $LAMBOW. I'm the memecoin for entrepreneurs and builders. Join the Alliance!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lambo_8498fe6ee2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

