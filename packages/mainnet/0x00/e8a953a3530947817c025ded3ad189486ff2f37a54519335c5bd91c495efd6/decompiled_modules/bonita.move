module 0xe8a953a3530947817c025ded3ad189486ff2f37a54519335c5bd91c495efd6::bonita {
    struct BONITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONITA>(arg0, 6, b"BONITA", b"Bonita", b"Master of the puppy dog eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3951_04a42c5052.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

