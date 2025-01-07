module 0x4c9c272f4637ed21472352c3c6796c484861d344e4970f81c3940836f4e9e1e6::bhsl {
    struct BHSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHSL>(arg0, 6, b"BHSL", b"Buy High Sell Low", b"The gangs of BUy HIGH seLL LoW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_04_at_1_20_29_AM_e1bc83f606.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

