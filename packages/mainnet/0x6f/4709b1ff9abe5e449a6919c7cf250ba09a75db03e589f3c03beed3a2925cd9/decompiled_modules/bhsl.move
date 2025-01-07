module 0x6f4709b1ff9abe5e449a6919c7cf250ba09a75db03e589f3c03beed3a2925cd9::bhsl {
    struct BHSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHSL>(arg0, 6, b"BHSL", b"BuyHighSellLow", b"The gangs of BUy HIGH seLL Low", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_04_at_1_12_29_AM_b8729355dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

