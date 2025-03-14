module 0xbdf738432267a3f22c38f3ee3e95c66c712f63b2b797f6b5e14cf57a35162003::nanc {
    struct NANC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NANC>, arg1: 0x2::coin::Coin<NANC>) {
        0x2::coin::burn<NANC>(arg0, arg1);
    }

    fun init(arg0: NANC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANC>(arg0, 8, b"MC", b"NANC", b"my coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANC>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NANC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NANC>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

