module 0x9482bd86cf10c151e2c4f5143c34edd83e9aa1b360b77413b34141f6776ec16c::dinosui {
    struct DINOSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DINOSUI>, arg1: 0x2::coin::Coin<DINOSUI>) {
        0x2::coin::burn<DINOSUI>(arg0, arg1);
    }

    fun init(arg0: DINOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOSUI>(arg0, 6, b"DINOSUI", b"Dino Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/C7GLZCN/dino.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DINOSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DINOSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DINOSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

