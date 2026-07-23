module 0x605c01b388d4642d57d923f61dba7b39ab8ee14dcc8f87644b7b4be25d2a8f3e::hUSDC {
    struct HUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSDC>(arg0, 6, b"hUSDC", b"hUSDC Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/husdc_9f3b616d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HUSDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

