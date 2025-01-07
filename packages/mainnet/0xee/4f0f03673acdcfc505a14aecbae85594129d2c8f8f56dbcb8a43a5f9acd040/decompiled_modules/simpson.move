module 0xee4f0f03673acdcfc505a14aecbae85594129d2c8f8f56dbcb8a43a5f9acd040::simpson {
    struct SIMPSON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIMPSON>, arg1: 0x2::coin::Coin<SIMPSON>) {
        0x2::coin::burn<SIMPSON>(arg0, arg1);
    }

    fun init(arg0: SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON>(arg0, 9, b"SIMPSON", b"SIMPSON", b"Simpson Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMPSON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIMPSON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

