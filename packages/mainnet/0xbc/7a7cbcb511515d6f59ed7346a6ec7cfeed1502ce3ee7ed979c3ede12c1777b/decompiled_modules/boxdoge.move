module 0xbc7a7cbcb511515d6f59ed7346a6ec7cfeed1502ce3ee7ed979c3ede12c1777b::boxdoge {
    struct BOXDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOXDOGE>, arg1: 0x2::coin::Coin<BOXDOGE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOXDOGE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOXDOGE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: BOXDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXDOGE>(arg0, 6, b"BOX DOGE", b"BDOGE", b"Box Doge is a fun and community-driven memecoin project with real utility, offering an all-in-one platform for token swaps, NFT creation/trading  https://boxdoge.xyz/  https://x.com/boxdoge_  https://t.me/boxdogeonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmZ4f8Zg2hSd8kUvLy4vkPUH9b8JFKyhdUBw9MuFdrvLZE")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOXDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<BOXDOGE>, arg1: 0x2::coin::Coin<BOXDOGE>) : u64 {
        0x2::coin::burn<BOXDOGE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<BOXDOGE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BOXDOGE> {
        0x2::coin::mint<BOXDOGE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

