module 0x612c5537ddf05f55c6fd82efb2072cee1772eb553c59de2483b797ed5e87bd14::ZUKA {
    struct ZUKA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZUKA>, arg1: 0x2::coin::Coin<ZUKA>) {
        0x2::coin::burn<ZUKA>(arg0, arg1);
    }

    fun init(arg0: ZUKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUKA>(arg0, 9, b"ZUKA", b"ZUKA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZUKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZUKA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

