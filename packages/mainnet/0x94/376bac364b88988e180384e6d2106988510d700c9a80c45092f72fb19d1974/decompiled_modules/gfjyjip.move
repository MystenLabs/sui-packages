module 0x94376bac364b88988e180384e6d2106988510d700c9a80c45092f72fb19d1974::gfjyjip {
    struct GFJYJIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFJYJIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFJYJIP>(arg0, 0, b"GFJYJIP", b"Sui Blue Gift Owner FJYJIP", b"Sui Blue Gift mainnet Gift owner smoke token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFJYJIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GFJYJIP>>(0x2::coin::mint<GFJYJIP>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFJYJIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

