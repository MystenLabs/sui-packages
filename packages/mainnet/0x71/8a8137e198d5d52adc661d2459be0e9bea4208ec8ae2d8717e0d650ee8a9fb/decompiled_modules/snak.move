module 0x718a8137e198d5d52adc661d2459be0e9bea4208ec8ae2d8717e0d650ee8a9fb::snak {
    struct SNAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAK>(arg0, 6, b"SNAK", b"Suinake", b"Suinake token with the largest community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953376841.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

