module 0x8ccd27b08dbe9e3aa9f208890b77489b56afdf7cee5ec55a1c0937da55e13586::hrmbe {
    struct HRMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRMBE>(arg0, 6, b"HRMBE", b"Harambe", b"Dicks out for Harambe. The angelic ape who died so we could thrive   | $HRMBE to the skies, where he resides.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4746_7aae9c7888.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRMBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRMBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

