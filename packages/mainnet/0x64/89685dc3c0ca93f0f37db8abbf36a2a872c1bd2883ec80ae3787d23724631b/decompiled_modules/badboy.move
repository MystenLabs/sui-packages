module 0x6489685dc3c0ca93f0f37db8abbf36a2a872c1bd2883ec80ae3787d23724631b::badboy {
    struct BADBOY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BADBOY>, arg1: 0x2::coin::Coin<BADBOY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BADBOY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BADBOY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BADBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADBOY>(arg0, 6, b"$BADBOY", b"BadBoy", b"$BADBOY Memecoin is a daring, edgy cryptocurrency project that embodies the rebellious spirit of meme culture.   https://x.com/badboyonsui   https://t.me/badboysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXQwrEZkTZZZ9wVjjcvMJgExzYoWrebRTVMC55ygkXDjW")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BADBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADBOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BADBOY>, arg1: 0x2::coin::Coin<BADBOY>) : u64 {
        0x2::coin::burn<BADBOY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BADBOY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BADBOY> {
        0x2::coin::mint<BADBOY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

