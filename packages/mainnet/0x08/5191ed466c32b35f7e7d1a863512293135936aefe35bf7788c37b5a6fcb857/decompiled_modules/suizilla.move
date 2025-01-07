module 0x85191ed466c32b35f7e7d1a863512293135936aefe35bf7788c37b5a6fcb857::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 6, b"SUIZILLA", b"Sui Godzilla", b"The beast has awakened! $SUIZILLA is the Godzilla of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1080_67ef49edff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

