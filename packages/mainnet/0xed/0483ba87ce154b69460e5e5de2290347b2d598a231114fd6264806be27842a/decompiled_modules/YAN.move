module 0xed0483ba87ce154b69460e5e5de2290347b2d598a231114fd6264806be27842a::YAN {
    struct YAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YAN>, arg1: 0x2::coin::Coin<YAN>) {
        0x2::coin::burn<YAN>(arg0, arg1);
    }

    fun init(arg0: YAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAN>(arg0, 9, b"YAN", b"YAN Test", b"My personal test coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

