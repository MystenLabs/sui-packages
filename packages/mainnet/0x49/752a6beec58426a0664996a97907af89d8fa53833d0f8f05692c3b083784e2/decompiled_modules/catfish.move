module 0x49752a6beec58426a0664996a97907af89d8fa53833d0f8f05692c3b083784e2::catfish {
    struct CATFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFISH>(arg0, 6, b"CATFISH", b"Catfish", b"NEVER EVER FALL IN LOVE WITH A MEMECOIN UNLESS ITS NAME IS $CATFISH ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cat_Fish_82717e4b10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

