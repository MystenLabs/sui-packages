module 0xcb44b7898e31545dd925ae02e50a3da3a10f71a7a1eb2bb8239ba592885a179a::meepo_faucet {
    struct MEEPO_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEEPO_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEEPO_FAUCET>(arg0, 8, b"MFC", b"Meepo coin faucet", b"Meepo coin faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEEPO_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MEEPO_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MEEPO_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MEEPO_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

