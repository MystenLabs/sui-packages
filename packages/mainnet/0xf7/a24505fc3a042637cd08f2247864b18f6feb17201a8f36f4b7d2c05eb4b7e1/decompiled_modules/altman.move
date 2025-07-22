module 0xf7a24505fc3a042637cd08f2247864b18f6feb17201a8f36f4b7d2c05eb4b7e1::altman {
    struct ALTMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALTMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALTMAN>(arg0, 9, b"Altman", b"Altman On Sui", b"Altman is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigdfvbhqfumfbbnugx36brzx6n3rc2mbcoxcby7ovhm3mufu2lqdy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALTMAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALTMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALTMAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

