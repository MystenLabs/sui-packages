module 0x575c33d8b8491f82b7b30244ff7bde2751d10e93abe762e22eb10dd18c38e26f::hhasui {
    struct HHASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHASUI>(arg0, 9, b"hhasui", b"hhasui Coin", b"hhasui Coin - yield-bearing representation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://curator-liquidity-mainnet.haedal.xyz/coin-icons/hhasui_c956b372c6.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHASUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHASUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

