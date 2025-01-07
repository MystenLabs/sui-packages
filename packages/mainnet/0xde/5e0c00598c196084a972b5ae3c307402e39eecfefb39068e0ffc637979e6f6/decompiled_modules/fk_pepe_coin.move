module 0xde5e0c00598c196084a972b5ae3c307402e39eecfefb39068e0ffc637979e6f6::fk_pepe_coin {
    struct FK_PEPE_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FK_PEPE_COIN>, arg1: 0x2::coin::Coin<FK_PEPE_COIN>) {
        0x2::coin::burn<FK_PEPE_COIN>(arg0, arg1);
    }

    fun init(arg0: FK_PEPE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FK_PEPE_COIN>(arg0, 9, b"FKPEPE", b"SuiFKPepeCoin", b"Fuck Pepe Coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://vqqiio2zgspcqwz354n4za2fr7pc7a24hgwipktz3gevluwnhjca.arweave.net/rCCEO1k0nihbO-8bzINFj94vg1w5rIeqedmJVdLNOkQ"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FK_PEPE_COIN>>(v1);
        0x2::coin::mint_and_transfer<FK_PEPE_COIN>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FK_PEPE_COIN>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FK_PEPE_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FK_PEPE_COIN>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

