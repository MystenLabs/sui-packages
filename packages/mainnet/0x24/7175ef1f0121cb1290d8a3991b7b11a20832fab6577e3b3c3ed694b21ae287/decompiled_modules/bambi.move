module 0x247175ef1f0121cb1290d8a3991b7b11a20832fab6577e3b3c3ed694b21ae287::bambi {
    struct BAMBI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BAMBI>, arg1: 0x2::coin::Coin<BAMBI>) {
        0x2::coin::burn<BAMBI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAMBI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BAMBI>>(0x2::coin::mint<BAMBI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BAMBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAMBI>(arg0, 9, b"bambi", b"BAMBI", b"bambi test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAMBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAMBI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

