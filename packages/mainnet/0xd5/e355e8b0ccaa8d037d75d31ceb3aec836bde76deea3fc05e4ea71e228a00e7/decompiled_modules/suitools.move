module 0xd5e355e8b0ccaa8d037d75d31ceb3aec836bde76deea3fc05e4ea71e228a00e7::suitools {
    struct SUITOOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOOLS>(arg0, 6, b"SUITOOLS", b"SuiTools", x"53756920636861696e206669727374207363616e6e657220626f74206c6976650a0a405375695f5363616e6e65725f426f74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027945_e1541d24d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

