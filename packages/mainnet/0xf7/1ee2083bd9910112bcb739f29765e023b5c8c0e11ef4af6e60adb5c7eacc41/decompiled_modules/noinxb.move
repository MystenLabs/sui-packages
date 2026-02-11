module 0xf71ee2083bd9910112bcb739f29765e023b5c8c0e11ef4af6e60adb5c7eacc41::noinxb {
    struct NOINXB has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOINXB>, arg1: 0x2::coin::Coin<NOINXB>) {
        0x2::coin::burn<NOINXB>(arg0, arg1);
    }

    fun init(arg0: NOINXB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOINXB>(arg0, 6, b"NOIXB", b"noinxb", b"nobinx is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOINXB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOINXB>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOINXB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOINXB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

