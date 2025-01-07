module 0x632c5466eaeaaa24f5f91d016481493949455ab8bbbec337bc6134c6991f825e::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGES>, arg1: 0x2::coin::Coin<DOGES>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGES>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGES>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 6, b"DOGES", b"Doges Play", b"Doges Play-to-Earn Memecoin $DOGES is a blockchain-based memecoin project that combines the fun of meme culture with the excitement of play-to-earn (P2E) gaming    https://x.com/dogessui_   https://t.me/dogessui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmSufKy1XCPWTBYwV8gV5vK3r1WDKDHRdCy9b8Axh1Vny3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<DOGES>, arg1: 0x2::coin::Coin<DOGES>) : u64 {
        0x2::coin::burn<DOGES>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<DOGES>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DOGES> {
        0x2::coin::mint<DOGES>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

