module 0x59c63697743ad161d4baac6e8a134856e0ed18d9a3df3063655d2889f3490232::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 6, b"SKIBIDI", b"Toilet War", b"real mf toilet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750300782736.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

