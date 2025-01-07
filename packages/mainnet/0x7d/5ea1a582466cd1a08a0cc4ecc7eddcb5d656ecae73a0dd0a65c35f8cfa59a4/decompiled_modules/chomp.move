module 0x7d5ea1a582466cd1a08a0cc4ecc7eddcb5d656ecae73a0dd0a65c35f8cfa59a4::chomp {
    struct CHOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMP>(arg0, 6, b"CHOMP", b"CHOMP COIN", b"THIS GUINEA PIG'S NOT JUST CUTE,.HE'S HERE TO RATTLE THE CAGE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6610ca08a3de6dd9847163e1_chomplogo256_56f141cf83.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

