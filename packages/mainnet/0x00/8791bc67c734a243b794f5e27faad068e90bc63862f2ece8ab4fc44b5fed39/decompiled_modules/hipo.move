module 0x8791bc67c734a243b794f5e27faad068e90bc63862f2ece8ab4fc44b5fed39::hipo {
    struct HIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPO>(arg0, 6, b"HIPO", b"Sui Hipo", b"Hipo is a rich hippo with prada glasses who likes making people cry and send to the moon with based holders only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_06_02_T210703_085_e67a7a7daf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

