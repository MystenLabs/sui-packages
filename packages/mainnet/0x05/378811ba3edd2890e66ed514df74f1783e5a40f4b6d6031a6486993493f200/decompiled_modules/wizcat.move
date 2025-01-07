module 0x5378811ba3edd2890e66ed514df74f1783e5a40f4b6d6031a6486993493f200::wizcat {
    struct WIZCAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WIZCAT>, arg1: 0x2::coin::Coin<WIZCAT>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIZCAT>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WIZCAT>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: WIZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIZCAT>(arg0, 6, b"WIZCAT", b"WCAT", b"It's Not Just Memecoins  https://www.wizcat.com/  https://x.com/wizcatsui  https://t.me/wizcatchannel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmSXE2fvT7jrxfqdWQjsthfYy8BqCpKNP4Fe3B2cP41HKs")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIZCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIZCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<WIZCAT>, arg1: 0x2::coin::Coin<WIZCAT>) : u64 {
        0x2::coin::burn<WIZCAT>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<WIZCAT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WIZCAT> {
        0x2::coin::mint<WIZCAT>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

