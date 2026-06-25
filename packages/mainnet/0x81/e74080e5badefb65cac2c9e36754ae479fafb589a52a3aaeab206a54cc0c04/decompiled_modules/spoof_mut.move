module 0x81e74080e5badefb65cac2c9e36754ae479fafb589a52a3aaeab206a54cc0c04::spoof_mut {
    struct SPOOF_MUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOOF_MUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOOF_MUT>(arg0, 9, b"BenignCoin", b"Benign Coin", b"Initially harmless; symbol mutable.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOOF_MUT>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPOOF_MUT>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

