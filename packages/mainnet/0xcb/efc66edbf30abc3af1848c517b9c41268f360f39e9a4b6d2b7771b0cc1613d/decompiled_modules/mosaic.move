module 0xcbefc66edbf30abc3af1848c517b9c41268f360f39e9a4b6d2b7771b0cc1613d::mosaic {
    struct MOSAIC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOSAIC>, arg1: 0x2::coin::Coin<MOSAIC>) {
        0x2::coin::burn<MOSAIC>(arg0, arg1);
    }

    fun init(arg0: MOSAIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSAIC>(arg0, 2, b"MO", b"MOSAIC", b"MOSAIC", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOSAIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSAIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOSAIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOSAIC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

