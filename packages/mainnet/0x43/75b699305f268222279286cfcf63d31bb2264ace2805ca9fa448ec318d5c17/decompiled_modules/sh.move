module 0x4375b699305f268222279286cfcf63d31bb2264ace2805ca9fa448ec318d5c17::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 6, b"SH", b"Shortist", b"We are a community that is tired of whales and soap bubbles. We are for an asset that only grows. It grows because people believe in it and, of course, because of human greed. Anyone can earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760958312681.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

