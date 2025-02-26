module 0x48da4710c1f55a2ac3051424bda5abaf7009fdd8105a6d780bfd38cd4a10a922::faucet {
    struct FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<FAUCET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET>(arg0, arg1, 0x2::tx_context::sender(arg2), arg2);
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET>(arg0, 9, b"HKing147", b"HKing147", b"this is HKing147's coin faucet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FAUCET>>(v0);
    }

    // decompiled from Move bytecode v6
}

