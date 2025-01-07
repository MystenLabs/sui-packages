module 0x52d5e36792556e4431bd647e98c3778ddd455f09534b541054ab131088eb24f8::yaha {
    struct YAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAHA>(arg0, 6, b"YAHA", b"YAHAonSUI", b"The next meme you will probably fade again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chomp_71f6360b25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

