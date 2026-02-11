module 0xf82293013a8594bda4daa5aea50155e3a34f7e13093ee5caee5cdc5651fb59ef::noinx {
    struct NOINX has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOINX>, arg1: 0x2::coin::Coin<NOINX>) {
        0x2::coin::burn<NOINX>(arg0, arg1);
    }

    fun init(arg0: NOINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOINX>(arg0, 6, b"NOIX", b"noinx", b"nobinx is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOINX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOINX>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOINX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOINX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

