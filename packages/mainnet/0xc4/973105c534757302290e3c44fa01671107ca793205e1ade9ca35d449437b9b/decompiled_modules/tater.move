module 0xc4973105c534757302290e3c44fa01671107ca793205e1ade9ca35d449437b9b::tater {
    struct TATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATER>(arg0, 6, b"TATER", b"Tater On Sui", b"Cutest dog born on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigvmftd7wpwwopcgkkz6ke7etzuin65zlzenyjifbw3zsamaxfcly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TATER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

