module 0x4a2320a5434f7fa8ba1141527c71e69dd681a4f2c8fa5d3d57bc1a9215ab1fad::wdedwed {
    struct WDEDWED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDEDWED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDEDWED>(arg0, 6, b"WDEDWED", b"wedwe", b"wddwd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDEDWED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDEDWED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

