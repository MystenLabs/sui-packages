module 0x54e8ac9c38f3eae084e66bafc8327ffb4045da9ff97d90a3e8be9890df0f796e::hamburgur {
    struct HAMBURGUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMBURGUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMBURGUR>(arg0, 9, b"HAMBURGUR", b"hamburgur", b"oiishi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HAMBURGUR>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMBURGUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

