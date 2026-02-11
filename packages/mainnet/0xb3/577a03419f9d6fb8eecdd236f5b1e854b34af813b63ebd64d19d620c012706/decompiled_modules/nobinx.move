module 0xb3577a03419f9d6fb8eecdd236f5b1e854b34af813b63ebd64d19d620c012706::nobinx {
    struct NOBINX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOBINX>, arg1: 0x2::coin::Coin<NOBINX>) {
        0x2::coin::burn<NOBINX>(arg0, arg1);
    }

    fun init(arg0: NOBINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBINX>(arg0, 6, b"NOBIX", b"nobinx", b"nobinx is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBINX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBINX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOBINX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOBINX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

