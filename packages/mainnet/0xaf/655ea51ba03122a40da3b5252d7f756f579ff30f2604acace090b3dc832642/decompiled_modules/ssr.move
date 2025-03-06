module 0xaf655ea51ba03122a40da3b5252d7f756f579ff30f2604acace090b3dc832642::ssr {
    struct SSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSR>(arg0, 6, b"SSR", b"Strategic SUI Reserve", x"507265736964656e74205472756d70277320576f726c64204c6962657274792046696e616e6369616c20706172746e65727320776974682053554920746f206c61756e63682061205374726174656769632053554920526573657276652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Captura_de_tela_2025_03_06_101740_f16e517667.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

