module 0xdff44103b1b61bccb9a41ec002d3a32c23459afc3b9787146c3fee1e80372a54::pikasui {
    struct PIKASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PIKASUI>, arg1: 0x2::coin::Coin<PIKASUI>) {
        0x2::coin::burn<PIKASUI>(arg0, arg1);
    }

    fun init(arg0: PIKASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKASUI>(arg0, 9, b"PIKA", b"PIKASUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIKASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIKASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

