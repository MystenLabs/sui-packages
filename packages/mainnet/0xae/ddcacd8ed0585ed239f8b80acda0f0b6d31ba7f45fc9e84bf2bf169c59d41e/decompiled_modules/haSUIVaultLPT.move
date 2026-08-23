module 0xaeddcacd8ed0585ed239f8b80acda0f0b6d31ba7f45fc9e84bf2bf169c59d41e::haSUIVaultLPT {
    struct HASUIVAULTLPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUIVAULTLPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUIVAULTLPT>(arg0, 9, b"haSUI Vault LPT", b"haSUI Vault LPT Coin", b"This token represents your deposited share in the Haedal Lending Vault. It automatically earns yield through optimized lending strategies across multiple protocols.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv-curator.haedal.xyz/Lendvault/lpt/hasuivaultlpt_ae75375d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HASUIVAULTLPT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUIVAULTLPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

