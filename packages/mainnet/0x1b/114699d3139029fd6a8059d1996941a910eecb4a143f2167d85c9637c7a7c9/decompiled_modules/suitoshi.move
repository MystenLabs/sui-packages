module 0x1b114699d3139029fd6a8059d1996941a910eecb4a143f2167d85c9637c7a7c9::suitoshi {
    struct SUITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOSHI>(arg0, 6, b"SUITOSHI", b"Suitoshi", b"Dive into the revolution of the crypto world with Suitoshi Nakamotothe dawn of a thrilling new era! Embrace the legacy and make your mark by investing in Suitoshi!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731017779708.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

