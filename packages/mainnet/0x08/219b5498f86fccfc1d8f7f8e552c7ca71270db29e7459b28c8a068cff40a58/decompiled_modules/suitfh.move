module 0x8219b5498f86fccfc1d8f7f8e552c7ca71270db29e7459b28c8a068cff40a58::suitfh {
    struct SUITFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITFH>(arg0, 6, b"SuiTFH", b"TFH", b"Extremely fast, secure and user-friendly website hosting for your successful online projects", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/27_2c991097bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

