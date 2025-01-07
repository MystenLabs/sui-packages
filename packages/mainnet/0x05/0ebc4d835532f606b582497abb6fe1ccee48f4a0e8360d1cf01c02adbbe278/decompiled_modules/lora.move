module 0x50ebc4d835532f606b582497abb6fe1ccee48f4a0e8360d1cf01c02adbbe278::lora {
    struct LORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORA>(arg0, 6, b"LORA", b"LORA SUI", x"4920616d20244c4f5241206c6574277320646576656c6f70206d6520746f67657468657220696e2074686520535549206e6574776f726b200a0a4a6f696e2075730a583a2068747470733a2f2f782e636f6d2f6c6f7261617375690a54454c454752414d3a2068747470733a2f2f742e6d652f6c6f7261737569706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul58_20250101043829_48f955edec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

