module 0x3249eeffb225547af777a21ecc4a084fea1e90fc8f4fe34caf0a62a4fa4a3e46::pawtato_coin_stone_block {
    struct PAWTATO_COIN_STONE_BLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_STONE_BLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_STONE_BLOCK>(arg0, 9, b"STONE_BLOCK", b"Pawtato Stone Block", b"Cut and shaped stone units for construction work.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/stone-block.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_STONE_BLOCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_STONE_BLOCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_stone_block(arg0: 0x2::coin::Coin<PAWTATO_COIN_STONE_BLOCK>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_STONE_BLOCK>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

