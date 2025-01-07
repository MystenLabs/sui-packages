module 0x203fd3bf8cf1ec8a76904039fb3f35ea4d8406f2da7e3b0fdbf8bc5bd184250a::cpgt {
    struct CPGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPGT>(arg0, 6, b"CPGT", b"Chain GPT", x"556e6c656173682074686520706f776572206f6620426c6f636b636861696e204149207769746820436861696e4750542e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CGPT_a4797292f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

