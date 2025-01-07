module 0xa7b5f0a5611815ec52db5b29f3a25f01405547a50a2102b3765292d2995429a6::fuu {
    struct FUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUU>(arg0, 6, b"FUU", b"Something", b"Something Traveled from the depths of the sui sea looking for BULB & FUD is Something a friend or foe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_123650291_1_3fee4a7bfa.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

