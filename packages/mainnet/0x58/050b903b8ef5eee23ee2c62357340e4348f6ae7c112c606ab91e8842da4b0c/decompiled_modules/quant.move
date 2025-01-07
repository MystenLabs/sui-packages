module 0x58050b903b8ef5eee23ee2c62357340e4348f6ae7c112c606ab91e8842da4b0c::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"QUANT", b"GenZ Quant", b"Let's join hands with Solana brothers to unwelcome this rugger on Sui chain aswell.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732134127872.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

