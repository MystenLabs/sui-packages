module 0x93b92e6d5889f06b9ae8bda33ac0378180b5b648b41a3e994aee1db6d78e8f26::yango {
    struct YANGO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YANGO>, arg1: 0x2::coin::Coin<YANGO>) {
        0x2::coin::burn<YANGO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YANGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YANGO>>(0x2::coin::mint<YANGO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: YANGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YANGO>(arg0, 9, b"yango", b"YANGO", b"testing yango", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YANGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YANGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

