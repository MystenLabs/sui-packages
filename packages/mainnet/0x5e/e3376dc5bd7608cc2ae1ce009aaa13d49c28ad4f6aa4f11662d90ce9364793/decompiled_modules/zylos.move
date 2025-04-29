module 0x5ee3376dc5bd7608cc2ae1ce009aaa13d49c28ad4f6aa4f11662d90ce9364793::zylos {
    struct ZYLOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYLOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYLOS>(arg0, 6, b"ZYLOS", b"ZYLOS CAT", x"48692065766572796f6e65204920616d205a796c6f730a54686520636f6f6c65737420636174206f6e207468652053554920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_03_17_20_57_59_d1c40b7d50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYLOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYLOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

