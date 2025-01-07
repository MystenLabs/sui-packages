module 0x8644207a17e11c23050716bb6aca2358755772a2fb5c43a757eec01ea8b7a0fb::summerswap {
    struct SUMMERSWAP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUMMERSWAP>, arg1: 0x2::coin::Coin<SUMMERSWAP>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUMMERSWAP>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUMMERSWAP>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUMMERSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMMERSWAP>(arg0, 6, b"Summer Swap", b"SUMMER", b"Summer Swap is a decentralized exchange (DEX) designed for fast, low-fee token swaps, staking, and yield farming.   https://www.summeronchain.fun/   https://x.com/summerswap_   https://t.me/summerswapsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUdrv5XPqNC8x3JumCfCGyMifSQTnjhxWM7Bv3T25cZd3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUMMERSWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMMERSWAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUMMERSWAP>, arg1: 0x2::coin::Coin<SUMMERSWAP>) : u64 {
        0x2::coin::burn<SUMMERSWAP>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUMMERSWAP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUMMERSWAP> {
        0x2::coin::mint<SUMMERSWAP>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

