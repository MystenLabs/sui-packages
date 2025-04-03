module 0x7177b88022dd59a07569c31d3813f9739877d8f28e37931812f7d70f2a5e3a85::minecraft {
    struct MINECRAFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINECRAFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINECRAFT>(arg0, 6, b"Minecraft", b"MINECRAFT", b"MINECRAFT HAS JOINED SUI!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743658407059.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINECRAFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINECRAFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

