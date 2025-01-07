module 0x475494d3da71045c9cf250843ce44dbdf6f959ff6f88468a9663bc96be721f74::catsu {
    struct CATSU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CATSU>, arg1: 0x2::coin::Coin<CATSU>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CATSU>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CATSU>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: CATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSU>(arg0, 6, b"CATSU", b"CatSui", b"Cat Sui Memecoin $CATSU is a community-driven cryptocurrency built around the theme of playful and mischievous cats.   https://x.com/catsui_   https://t.me/catsuilabs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmWZdJzCc82JY1enXpqhzKWiCPNuk1RsQwhLoVm62FRHyN")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<CATSU>, arg1: 0x2::coin::Coin<CATSU>) : u64 {
        0x2::coin::burn<CATSU>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<CATSU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CATSU> {
        0x2::coin::mint<CATSU>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

