module 0x1c3c75c0f4b6e635533a3b819854d706b3b5358d487821dbe66039d58be451d5::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 6, b"DAM", b"Dam on Sui", b"WELCOME COMMUNITY $DAM ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000028337_38dc0d2c15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

