module 0xeed6fbcbf6bfc4f0ae2800dd15d401d343614d785accea406a26c37c322b30d6::TOMOE {
    struct TOMOE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOMOE>, arg1: 0x2::coin::Coin<TOMOE>) {
        0x2::coin::burn<TOMOE>(arg0, arg1);
    }

    fun init(arg0: TOMOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMOE>(arg0, 9, b"TOMOE", b"Tomoe Dragon", b"Tomoe Dragon Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/JQPQ1ZN/tomoe.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOMOE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOMOE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

