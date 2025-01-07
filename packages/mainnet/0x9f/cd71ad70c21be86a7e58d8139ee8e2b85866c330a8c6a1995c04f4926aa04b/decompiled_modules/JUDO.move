module 0x9fcd71ad70c21be86a7e58d8139ee8e2b85866c330a8c6a1995c04f4926aa04b::JUDO {
    struct JUDO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JUDO>, arg1: 0x2::coin::Coin<JUDO>) {
        0x2::coin::burn<JUDO>(arg0, arg1);
    }

    fun init(arg0: JUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUDO>(arg0, 9, b"JUDO", b"JUDO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/xf1Z40t/judo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUDO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUDO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

