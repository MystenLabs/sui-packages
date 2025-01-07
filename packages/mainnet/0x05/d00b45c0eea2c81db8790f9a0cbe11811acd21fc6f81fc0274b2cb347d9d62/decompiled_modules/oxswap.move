module 0x5d00b45c0eea2c81db8790f9a0cbe11811acd21fc6f81fc0274b2cb347d9d62::oxswap {
    struct OXSWAP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OXSWAP>, arg1: 0x2::coin::Coin<OXSWAP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OXSWAP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OXSWAP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: OXSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXSWAP>(arg0, 6, b"OX", b"OXSWAP", b"Ox Swap is a cross-chain decentralized exchange (DEX) designed to provide users with fast, secure, and low-cost token swaps across multiple blockchain networks.  https://oxcoin.xyz   https://x.com/oxswap_   https://t.me/oxswapsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmV5WoaTPeW4CqzEdDHU7m1h9ZQeMYMvvo4yxw1Z2pgn9G")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OXSWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OXSWAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<OXSWAP>, arg1: 0x2::coin::Coin<OXSWAP>) : u64 {
        0x2::coin::burn<OXSWAP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<OXSWAP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<OXSWAP> {
        0x2::coin::mint<OXSWAP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

