module 0xb58b10973bf2f5036aa50dd6e48c1cd7d089806a7fe467c028565782a40fb8f0::fiveshots {
    struct FIVESHOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIVESHOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVESHOTS>(arg0, 9, b"FIVESHOTS", b"5shots", b"5shots NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ed4caf4-6a84-4fa6-99d6-aaf0d2a7e5fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVESHOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIVESHOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

