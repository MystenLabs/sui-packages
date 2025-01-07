module 0x8af0785969211250f79eec2391cc1a2b41729a564ccbc74786b8250e2fff6289::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 6, b"SUIAI", b"SuiAI", x"546865204f6666696369616c20535549204149200a4a6f696e2074686520436f6d6d756e697479206f6e20582026206f6e2053756941692e78797a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_AI_59d03919ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

