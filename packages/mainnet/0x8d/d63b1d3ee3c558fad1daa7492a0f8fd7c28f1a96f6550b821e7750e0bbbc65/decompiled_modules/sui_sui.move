module 0x8dd63b1d3ee3c558fad1daa7492a0f8fd7c28f1a96f6550b821e7750e0bbbc65::sui_sui {
    struct SUI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_SUI>(arg0, 9, b"suiSUI", b"Sui Staked SUI", b"Sui Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/bd29faef-6c00-4a44-beff-c1196a8753ee/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

