module 0xdcab79b5c8f74e544f9b7232828a15ef7718a11ab9556901c94b0807a78c20c8::chloe {
    struct CHLOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHLOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHLOE>(arg0, 6, b"CHLOE", b"CHLOE DOG OF SUI", b"CHLOE THE DOG OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_10_54_23_1f0c2b765a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHLOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHLOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

