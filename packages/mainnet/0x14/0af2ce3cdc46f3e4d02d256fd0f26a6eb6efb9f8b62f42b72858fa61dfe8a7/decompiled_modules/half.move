module 0x140af2ce3cdc46f3e4d02d256fd0f26a6eb6efb9f8b62f42b72858fa61dfe8a7::half {
    struct HALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALF>(arg0, 6, b"HALF", b"HALFSUI", b"Half Sui Half Bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_23_17_42_e7c8f99f71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALF>>(v1);
    }

    // decompiled from Move bytecode v6
}

