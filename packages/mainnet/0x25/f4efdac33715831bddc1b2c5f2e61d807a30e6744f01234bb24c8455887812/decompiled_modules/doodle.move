module 0x25f4efdac33715831bddc1b2c5f2e61d807a30e6744f01234bb24c8455887812::doodle {
    struct DOODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODLE>(arg0, 6, b"DOODLE", b"DOODLES", b"In honor of my pocket friend who will be going to forever sleep tomorrow. I love and will miss you forever. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003132_bc0a797e1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

