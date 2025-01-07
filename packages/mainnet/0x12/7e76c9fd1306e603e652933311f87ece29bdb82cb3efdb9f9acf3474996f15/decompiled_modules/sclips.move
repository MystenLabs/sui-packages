module 0x127e76c9fd1306e603e652933311f87ece29bdb82cb3efdb9f9acf3474996f15::sclips {
    struct SCLIPS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SCLIPS>, arg1: 0x2::coin::Coin<SCLIPS>) {
        0x2::coin::burn<SCLIPS>(arg0, arg1);
    }

    fun init(arg0: SCLIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCLIPS>(arg0, 18, b"SCLIPS", b"SCLIPS", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCLIPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCLIPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SCLIPS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SCLIPS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

