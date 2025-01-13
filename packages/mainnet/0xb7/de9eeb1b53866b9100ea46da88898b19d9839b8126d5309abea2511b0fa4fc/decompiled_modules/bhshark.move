module 0xb7de9eeb1b53866b9100ea46da88898b19d9839b8126d5309abea2511b0fa4fc::bhshark {
    struct BHSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHSHARK>(arg0, 6, b"BHSHARK", b"BULLSHARK", b"Meet the Bullsharks:Swift, strong, and determined. Bullsharks lead the Sui blockchain ocean with strategy and precision. Join their relentless journey today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_04_06_08_38_bb1f080602.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

