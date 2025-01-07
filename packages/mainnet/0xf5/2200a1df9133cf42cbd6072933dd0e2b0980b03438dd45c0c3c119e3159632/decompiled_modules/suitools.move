module 0xf52200a1df9133cf42cbd6072933dd0e2b0980b03438dd45c0c3c119e3159632::suitools {
    struct SUITOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOLS>(arg0, 6, b"SUITOOLS", b"SuiTools", x"53756920636861696e207375697363616e6e657220626f74206973206c6976650a405375695f5363616e6e65725f426f740a405375695f5363616e6e65725f426f740a0a0a4c6f6e67207465726d207574696c6974792070726f6a656374200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027945_e6a7244164.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

