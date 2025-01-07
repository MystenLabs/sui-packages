module 0xd84359e396d5232fcb91b890d80ce4a94b4f419f62062642c81e78676bc07864::aipepe {
    struct AIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIPEPE>, arg1: 0x2::coin::Coin<AIPEPE>) {
        0x2::coin::burn<AIPEPE>(arg0, arg1);
    }

    fun init(arg0: AIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIPEPE>(arg0, 2, b"AIPEPE", b"AIPEPE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ibb.co/Pcy2KRK")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

