module 0x6ff12a5759a7507a0cf48378868c92dce4c4de4c25f11213858212f497b9ddec::chenerge_faucet {
    struct CHENERGE_FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHENERGE_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHENERGE_FAUCET>(arg0, 6, b"CHENERGE_FAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHENERGE_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CHENERGE_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHENERGE_FAUCET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHENERGE_FAUCET>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    // decompiled from Move bytecode v6
}

