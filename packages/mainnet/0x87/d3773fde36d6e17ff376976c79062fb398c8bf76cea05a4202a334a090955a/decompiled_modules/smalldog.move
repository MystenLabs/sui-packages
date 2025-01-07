module 0x87d3773fde36d6e17ff376976c79062fb398c8bf76cea05a4202a334a090955a::smalldog {
    struct SMALLDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMALLDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMALLDOG>(arg0, 6, b"SmallDog", b"small dog", b"smally", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732173898249.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMALLDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMALLDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

