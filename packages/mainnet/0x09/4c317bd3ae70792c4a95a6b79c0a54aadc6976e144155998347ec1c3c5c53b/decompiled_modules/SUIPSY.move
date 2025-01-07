module 0x94c317bd3ae70792c4a95a6b79c0a54aadc6976e144155998347ec1c3c5c53b::SUIPSY {
    struct SUIPSY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPSY>, arg1: 0x2::coin::Coin<SUIPSY>) {
        0x2::coin::burn<SUIPSY>(arg0, arg1);
    }

    fun init(arg0: SUIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPSY>(arg0, 9, b"PSY", b"SUIPSY", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPSY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPSY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPSY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPSY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

