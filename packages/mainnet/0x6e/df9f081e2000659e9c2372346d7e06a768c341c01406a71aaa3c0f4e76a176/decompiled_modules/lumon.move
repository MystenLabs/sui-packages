module 0x6edf9f081e2000659e9c2372346d7e06a768c341c01406a71aaa3c0f4e76a176::lumon {
    struct LUMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMON>(arg0, 6, b"LUMON", b"Lumon Industries ", b"All Hail Kier!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739333526882.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUMON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

