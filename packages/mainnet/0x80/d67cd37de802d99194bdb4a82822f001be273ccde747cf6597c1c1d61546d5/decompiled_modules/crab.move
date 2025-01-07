module 0x80d67cd37de802d99194bdb4a82822f001be273ccde747cf6597c1c1d61546d5::crab {
    struct CRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAB>(arg0, 6, b"CRAB", b"Crab Rave", x"4a6f696e2043524142207261766521200a53686f74732073686f74732073686f74732073686f74732073686f74730a435241422043524142204352414220435241422043524142", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/message_Image_1727922296897_5197bf6b25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

