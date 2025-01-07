module 0x3f92b1779b72e66606333f8c062f0e728663f7fd598c812dc2e6fbb9f1f4c61c::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"Suiton", b"$Suiton", b"Suiton : movepump launch no jutsu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiton_image_2ed389ebd7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITON>>(v1);
    }

    // decompiled from Move bytecode v6
}

