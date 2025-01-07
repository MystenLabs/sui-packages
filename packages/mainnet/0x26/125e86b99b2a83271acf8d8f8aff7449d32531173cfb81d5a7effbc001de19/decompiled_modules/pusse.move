module 0x26125e86b99b2a83271acf8d8f8aff7449d32531173cfb81d5a7effbc001de19::pusse {
    struct PUSSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSE>(arg0, 6, b"PUSSE", b"Pusse On Sui", b"Dexsceener paid. 100% Community driven.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_dfc307196f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

