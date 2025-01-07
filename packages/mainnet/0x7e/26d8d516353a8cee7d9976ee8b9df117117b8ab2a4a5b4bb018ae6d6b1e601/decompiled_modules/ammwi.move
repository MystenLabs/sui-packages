module 0x7e26d8d516353a8cee7d9976ee8b9df117117b8ab2a4a5b4bb018ae6d6b1e601::ammwi {
    struct AMMWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMMWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMMWI>(arg0, 6, b"AMMWI", b"AMMWI SUI", b"It will be a forum of people discussing various strategies and information. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_20_15_45_00fc31ab91.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMMWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AMMWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

