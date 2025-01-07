module 0x43679cbfd419c20636813aed042b0f3e0e92aff2a2d856b3f05fff65459157b3::kill {
    struct KILL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KILL>, arg1: 0x2::coin::Coin<KILL>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KILL>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KILL>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILL>(arg0, 6, b"KILL", b"Kill Zero", b"KILL ZERO IS A SUPER POWERFUL MEME TOKEN ON SUI NETWORK    https://killzero.pro   https://x.com/killzerosui    https://t.me/+ZKmNxs-JIfQxMDY9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTGCVovE9LVpnqgqxv2zwND8TT4aahgaa5nPJtgPBgh8r")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KILL>, arg1: 0x2::coin::Coin<KILL>) : u64 {
        0x2::coin::burn<KILL>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KILL>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KILL> {
        0x2::coin::mint<KILL>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

