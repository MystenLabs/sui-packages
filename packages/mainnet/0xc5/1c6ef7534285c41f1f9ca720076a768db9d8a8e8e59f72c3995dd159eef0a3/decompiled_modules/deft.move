module 0xc51c6ef7534285c41f1f9ca720076a768db9d8a8e8e59f72c3995dd159eef0a3::deft {
    struct DEFT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DEFT>, arg1: 0x2::coin::Coin<DEFT>) {
        0x2::coin::burn<DEFT>(arg0, arg1);
    }

    fun init(arg0: DEFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DEFT>(arg0, 0, b"DEFT", b"Deft", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEFT>>(v2);
        let v4 = &mut v3;
        mint(v4, 21000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFT>>(v3, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEFT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DEFT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

