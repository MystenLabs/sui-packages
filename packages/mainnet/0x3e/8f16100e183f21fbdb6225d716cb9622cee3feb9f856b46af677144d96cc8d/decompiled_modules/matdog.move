module 0x3e8f16100e183f21fbdb6225d716cb9622cee3feb9f856b46af677144d96cc8d::matdog {
    struct MATDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATDOG>(arg0, 6, b"MATDOG", b"MAT", b"Mat dog turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730990067466.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MATDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

