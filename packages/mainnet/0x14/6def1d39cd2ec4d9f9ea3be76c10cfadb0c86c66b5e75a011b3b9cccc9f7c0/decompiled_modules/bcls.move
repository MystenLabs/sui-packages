module 0x146def1d39cd2ec4d9f9ea3be76c10cfadb0c86c66b5e75a011b3b9cccc9f7c0::bcls {
    struct BCLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCLS>(arg0, 9, b"BCLS", b"Bacillus", b"Bacillus (BCLS) is a unique cryptocurrency designed with a focus on decentralized finance (DeFi) ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a783d366-4e87-4813-bda0-37205e7f6824.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

