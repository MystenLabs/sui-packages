module 0xa42bb0b5057a18d4b9dc63da057d48ddc1ac53d2f56c453fa3a095beb14cb540::xbin {
    struct XBIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XBIN>, arg1: 0x2::coin::Coin<XBIN>) {
        0x2::coin::burn<XBIN>(arg0, arg1);
    }

    fun init(arg0: XBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBIN>(arg0, 6, b"XBIN", b"xbin", b"MintForgek is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XBIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XBIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

