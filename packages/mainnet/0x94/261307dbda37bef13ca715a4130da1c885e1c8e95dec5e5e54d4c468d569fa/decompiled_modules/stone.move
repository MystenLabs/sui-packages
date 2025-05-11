module 0x94261307dbda37bef13ca715a4130da1c885e1c8e95dec5e5e54d4c468d569fa::stone {
    struct STONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONE>(arg0, 9, b"STONE", b"STONE", b"STONE", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<STONE>>(0x2::coin::mint<STONE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STONE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STONE>>(v2);
    }

    // decompiled from Move bytecode v6
}

