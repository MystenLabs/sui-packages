module 0xbc6747c695b793510a40908e83617b4a64160a86f0a541a04da1cfd8e56ac91::sui_bonk {
    struct SUI_BONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_BONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_BONK>(arg0, 9, b"SUI BONK", b"SBONK", b"Sui Bonk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x030bccd304b2922d51823de94e5905a389c24b052dd870698c4874d52a22864d::sbonk::sbonk.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_BONK>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_BONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_BONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

