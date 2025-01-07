module 0xaabdb52f57976dd51cdc2d7cac409822cec1221b4ab98db3b3362c302761be03::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROCKY>, arg1: 0x2::coin::Coin<ROCKY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROCKY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ROCKY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 6, b"$ROCKY", b"Rocky", b"$Rock  is a Powerfull #meme token   https://www.rockk.xyz/  https://x.com/rocksonsui   https://t.me/rockonsuiportal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUm8ka8idbRtEC6KxC4Udnf72TdyhKkEyqAJjvED4JouD")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<ROCKY>, arg1: 0x2::coin::Coin<ROCKY>) : u64 {
        0x2::coin::burn<ROCKY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<ROCKY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ROCKY> {
        0x2::coin::mint<ROCKY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

