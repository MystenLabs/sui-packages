module 0x151a9dd6377cf292c9ded75127078462544a4baf702fc226b9d39cb780966bc5::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 6, b"MARS", b"Occupy MARS", b"Elon is occupying Mars. For each $1 of market cap gained Elon brings 1 person to Mars. Let's bring all 7 Billion people to Mars.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MARS_b934a16e27.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

