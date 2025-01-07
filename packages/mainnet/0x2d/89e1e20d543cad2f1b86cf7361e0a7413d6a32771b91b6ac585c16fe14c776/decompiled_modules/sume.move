module 0x2d89e1e20d543cad2f1b86cf7361e0a7413d6a32771b91b6ac585c16fe14c776::sume {
    struct SUME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUME>, arg1: 0x2::coin::Coin<SUME>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUME>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUME>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: SUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUME>(arg0, 6, b"SUME SUI", b"SUME", b"SUME is a decentralized platform that focuses on tracking, trading, and ranking the most trending memecoins in the cryptocurrency world.   https://x.com/suimeme_   https://t.me/sumeonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmTSufpYBADUpR6R45khN1LEcd87vNDsfFZedto6jPZ58j")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUME>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<SUME>, arg1: 0x2::coin::Coin<SUME>) : u64 {
        0x2::coin::burn<SUME>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<SUME>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUME> {
        0x2::coin::mint<SUME>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

