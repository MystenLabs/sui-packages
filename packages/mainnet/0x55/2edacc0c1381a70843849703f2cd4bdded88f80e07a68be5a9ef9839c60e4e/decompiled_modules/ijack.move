module 0x552edacc0c1381a70843849703f2cd4bdded88f80e07a68be5a9ef9839c60e4e::ijack {
    struct IJACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IJACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IJACK>(arg0, 0, b"IJACK", b"IJACK TOKEN", b"The ultimate JackMachine Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<IJACK>(&mut v3, 20000, v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IJACK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IJACK>>(v3, v0);
    }

    // decompiled from Move bytecode v6
}

