module 0x95d491147d9e6671ecb4c4b881038cd7a1c808a069040c2f5de460c9cf32ca72::iag {
    struct IAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAG>(arg0, 6, b"IAG", b"I AGENT", b"Gaming AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_11_20_09_54bce1bbee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

