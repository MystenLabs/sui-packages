module 0xa131ea0236c1f626ba1ae2e30648b86d0bf8cc33191bec8ddbd071a77a1e3d37::duckjoker {
    struct DUCKJOKER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCKJOKER>, arg1: 0x2::coin::Coin<DUCKJOKER>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCKJOKER>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DUCKJOKER>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DUCKJOKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKJOKER>(arg0, 6, b"DUJO", b"Duck Joker", b"Duck Joker Coin is a whimsical and engaging memecoin that merges the playful nature of ducks with the iconic, mischievous character of the Joker.      https://www.dujo.pro/   https://x.com/dujosui   ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmayiyyoX6Ma66Tk6xRAaZfFsm3K6vEbdk6g57papUxBdz")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKJOKER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKJOKER>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DUCKJOKER>, arg1: 0x2::coin::Coin<DUCKJOKER>) : u64 {
        0x2::coin::burn<DUCKJOKER>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DUCKJOKER>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DUCKJOKER> {
        0x2::coin::mint<DUCKJOKER>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

