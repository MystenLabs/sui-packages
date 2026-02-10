module 0xdfe54c5fa76a52588ba9f1f5a3f1cb0682a84af25c301ed890ec7a0f98557970::mintforgek {
    struct MINTFORGEK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MINTFORGEK>, arg1: 0x2::coin::Coin<MINTFORGEK>) {
        0x2::coin::burn<MINTFORGEK>(arg0, arg1);
    }

    fun init(arg0: MINTFORGEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINTFORGEK>(arg0, 6, b"FOGK", b"MintForgek", b"MintForgek is an experimental on-chain token exploring fair launch mechanics and community-driven liquidity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1630359280867057664/nX9XPYYO_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINTFORGEK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINTFORGEK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MINTFORGEK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MINTFORGEK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

