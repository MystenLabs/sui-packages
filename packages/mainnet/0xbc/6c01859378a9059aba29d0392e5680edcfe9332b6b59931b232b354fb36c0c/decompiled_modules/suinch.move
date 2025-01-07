module 0xbc6c01859378a9059aba29d0392e5680edcfe9332b6b59931b232b354fb36c0c::suinch {
    struct SUINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINCH>(arg0, 6, b"SUINCH", b"Suinch", b"Sui Snatcher Grinch Token Meme for Christmas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734290412525.59")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

