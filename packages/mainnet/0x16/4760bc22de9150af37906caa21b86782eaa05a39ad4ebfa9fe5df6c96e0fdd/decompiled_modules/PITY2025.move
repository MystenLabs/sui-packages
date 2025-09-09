module 0x164760bc22de9150af37906caa21b86782eaa05a39ad4ebfa9fe5df6c96e0fdd::PITY2025 {
    struct PITY2025 has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: u64, arg1: &mut 0x2::coin::TreasuryCap<PITY2025>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PITY2025>>(0x2::coin::mint<PITY2025>(arg1, arg0, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<PITY2025>>(0x2::coin::mint<PITY2025>(arg1, arg0, arg4), arg3);
    }

    fun init(arg0: PITY2025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PITY2025>(arg0, 6, b"PITY", b"PITY Coin", b"PITY Coin", 0x1::option::none<0x2::url::Url>(), false, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITY2025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::DenyCapV2<PITY2025>>(v1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITY2025>>(v2);
    }

    // decompiled from Move bytecode v6
}

