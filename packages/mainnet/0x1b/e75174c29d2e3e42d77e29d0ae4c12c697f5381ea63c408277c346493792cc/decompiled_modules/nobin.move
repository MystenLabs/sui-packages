module 0x1be75174c29d2e3e42d77e29d0ae4c12c697f5381ea63c408277c346493792cc::nobin {
    struct NOBIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOBIN>, arg1: 0x2::coin::Coin<NOBIN>) {
        0x2::coin::burn<NOBIN>(arg0, arg1);
    }

    fun init(arg0: NOBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBIN>(arg0, 6, b"NOBI", b"nobin", b"nobin is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOBIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOBIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

