module 0xd2a41cd922e3f6990379dec04bd68e5b79665693af9f0500ce889c5c2095b548::morn {
    struct MORN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MORN>, arg1: 0x2::coin::Coin<MORN>) {
        0x2::coin::burn<MORN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MORN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MORN>>(0x2::coin::mint<MORN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORN>(arg0, 9, b"morn", b"MORN", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

