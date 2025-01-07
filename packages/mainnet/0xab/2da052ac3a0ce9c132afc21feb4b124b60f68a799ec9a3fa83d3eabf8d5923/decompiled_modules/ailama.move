module 0xab2da052ac3a0ce9c132afc21feb4b124b60f68a799ec9a3fa83d3eabf8d5923::ailama {
    struct AILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AILAMA>(arg0, 6, b"AILAMA", b"DalAi Lama", b"The First Ai Lama.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_05_alle_10_41_40_18cebec01c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AILAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

