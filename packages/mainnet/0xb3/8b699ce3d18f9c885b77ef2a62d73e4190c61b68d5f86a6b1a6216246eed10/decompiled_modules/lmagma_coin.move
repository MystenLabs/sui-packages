module 0xb38b699ce3d18f9c885b77ef2a62d73e4190c61b68d5f86a6b1a6216246eed10::lmagma_coin {
    struct LMAGMA_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LMAGMA_COIN>, arg1: 0x2::coin::Coin<LMAGMA_COIN>) {
        0x2::coin::burn<LMAGMA_COIN>(arg0, arg1);
    }

    fun init(arg0: LMAGMA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMAGMA_COIN>(arg0, 9, b"LMAGMA", b"LMagma.com", b"lMAGMA is the official yield-accruing token of MAGMA FINANCE. Earn rewards, withdraw accrued yield, and access your lMAGMA tokens directly through the LMagma.com platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/lmagma28/mag28/refs/heads/main/lmagma.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMAGMA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAGMA_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LMAGMA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LMAGMA_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

