module 0x6faa8357499449df618415c73fe7d3795de897ab6b9344ef1b7d98cd46e64518::krusty {
    struct KRUSTY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KRUSTY>, arg1: 0x2::coin::Coin<KRUSTY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KRUSTY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KRUSTY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KRUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRUSTY>(arg0, 6, b"$KRUSTY", b"Krusty Sui", b"$KRUSTY Meme-based cryptocurrency built around humor, laughter, and community. Inspired by the quirky, humorous nature of characters Krusty the Clown.     https://krustysui.com/   https://x.com/krustysui  https://t.me/krustysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZkLsqdDkNPyUqDuruJFpzytFPhLRfEBUpu5JnSwcN3oQ")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRUSTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRUSTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KRUSTY>, arg1: 0x2::coin::Coin<KRUSTY>) : u64 {
        0x2::coin::burn<KRUSTY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KRUSTY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KRUSTY> {
        0x2::coin::mint<KRUSTY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

