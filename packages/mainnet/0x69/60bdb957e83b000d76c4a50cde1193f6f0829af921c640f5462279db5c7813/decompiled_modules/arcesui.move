module 0x6960bdb957e83b000d76c4a50cde1193f6f0829af921c640f5462279db5c7813::arcesui {
    struct ARCESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCESUI>(arg0, 2, b"ASUI", b"ARCESUI", b"ARCESUI COIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/sRf5g39.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 100000000000, v4, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARCESUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ARCESUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ARCESUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ARCESUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

