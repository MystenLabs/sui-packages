module 0x7b8c012a2f861d3fde9f070dd063a37acac3ed5ebe0e02aee865e8cf479bfb0a::sotter {
    struct SOTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOTTER>(arg0, 6, b"SOTTER", b"SUI OTTER", x"546865206d6173636f74206f662053756920636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sotterlogo_dd28ba2cb8_8ac344cd61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

