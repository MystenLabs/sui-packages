module 0x6d3c19956a8516db444adafaf6a2ce890049e8d7bbd4ce692fb06f1d729f43c7::venom {
    struct VENOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VENOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VENOM>(arg0, 9, b"VENOM", b"Venom", b"Venom in your mind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shutterstock.com/image-vector/venom-art-design-logo-sign-260nw-2337444245.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VENOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VENOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

