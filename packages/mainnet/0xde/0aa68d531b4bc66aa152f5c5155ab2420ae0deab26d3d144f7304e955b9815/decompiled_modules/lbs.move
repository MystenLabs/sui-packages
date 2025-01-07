module 0xde0aa68d531b4bc66aa152f5c5155ab2420ae0deab26d3d144f7304e955b9815::lbs {
    struct LBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBS>(arg0, 6, b"LBS", b"Labusui", b"The monster teddy bear has appeared on SUI. Quickly own it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_20_21_14_6e76089f24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

