module 0xd637f55a350626a3adab831e56e80a640b90b1a6c4c13424a1345f5473cb39eb::hUSDC {
    struct HUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDC>(arg0, 6, b"hUSDC", b"hUSDC Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/husdc_ae2f27cc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUSDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

