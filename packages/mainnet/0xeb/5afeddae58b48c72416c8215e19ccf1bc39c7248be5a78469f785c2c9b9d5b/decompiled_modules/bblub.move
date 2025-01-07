module 0xeb5afeddae58b48c72416c8215e19ccf1bc39c7248be5a78469f785c2c9b9d5b::bblub {
    struct BBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBLUB>(arg0, 6, b"BBLUB", b"BABY BLUB", b"\"Baby Blub on Sui\" is an adorable and playful project that brings the charming Baby Blub character to life within the Sui blockchain ecosystem. Baby Blub, a tiny and lovable aquatic creature, embarks on exciting adventures in a decentralized world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735926902448.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBLUB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBLUB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

