module 0x3e1c85511dba1fe83d94286d0de6d621d2fbad458a326d5dddd1e97988f76bc8::gbl {
    struct GBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBL>(arg0, 9, b"GBL", b"GOLDENBOOL", b"Bull Market Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65835b7c-5bd7-49a6-aa47-3fe15204acf0-1000019199.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

