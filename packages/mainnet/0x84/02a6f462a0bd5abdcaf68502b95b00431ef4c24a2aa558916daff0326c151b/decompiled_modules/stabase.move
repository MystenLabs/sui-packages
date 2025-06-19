module 0x8402a6f462a0bd5abdcaf68502b95b00431ef4c24a2aa558916daff0326c151b::stabase {
    struct STABASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STABASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STABASE>(arg0, 6, b"Stabase", b"stabase", b"Stabase is cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750327761726.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STABASE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STABASE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

