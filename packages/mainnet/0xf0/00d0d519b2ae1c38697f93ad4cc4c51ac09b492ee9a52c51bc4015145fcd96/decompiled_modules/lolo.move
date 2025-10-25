module 0xf000d0d519b2ae1c38697f93ad4cc4c51ac09b492ee9a52c51bc4015145fcd96::lolo {
    struct LOLO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LOLO>, arg1: 0x2::coin::Coin<LOLO>) {
        0x2::coin::burn<LOLO>(arg0, arg1);
    }

    fun init(arg0: LOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLO>(arg0, 9, b"lolo", b"LOLO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://34.27.172.105/uploads/logo_1761402839081_440ac8c7.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOLO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LOLO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

