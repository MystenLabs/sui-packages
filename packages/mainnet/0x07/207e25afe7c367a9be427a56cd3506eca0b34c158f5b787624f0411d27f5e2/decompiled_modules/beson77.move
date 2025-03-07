module 0x7207e25afe7c367a9be427a56cd3506eca0b34c158f5b787624f0411d27f5e2::beson77 {
    struct BESON77 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BESON77>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BESON77>>(0x2::coin::mint<BESON77>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BESON77, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BESON77>(arg0, 9, b"BESON77", b"BESON77", b"BESON77", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BESON77>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BESON77>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

