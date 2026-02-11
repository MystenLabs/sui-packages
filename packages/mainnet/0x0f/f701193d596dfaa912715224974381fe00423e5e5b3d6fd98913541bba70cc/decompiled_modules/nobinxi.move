module 0xff701193d596dfaa912715224974381fe00423e5e5b3d6fd98913541bba70cc::nobinxi {
    struct NOBINXI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOBINXI>, arg1: 0x2::coin::Coin<NOBINXI>) {
        0x2::coin::burn<NOBINXI>(arg0, arg1);
    }

    fun init(arg0: NOBINXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBINXI>(arg0, 9, b"NBXI", b"nobinxi", b"nobinx is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBINXI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBINXI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOBINXI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOBINXI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

