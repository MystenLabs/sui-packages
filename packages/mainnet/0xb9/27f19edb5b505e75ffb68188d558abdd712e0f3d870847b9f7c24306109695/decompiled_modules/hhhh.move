module 0xb927f19edb5b505e75ffb68188d558abdd712e0f3d870847b9f7c24306109695::hhhh {
    struct HHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHHH>(arg0, 9, b"HHHH", b"hhhh", b"hhhhhhhh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHHH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHHH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

