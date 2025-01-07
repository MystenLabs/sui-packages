module 0x414a149d2336aebb4bd4349ccf6ea1421569ec7c04d2a27d7f7a4e3e864d4e8f::popdoge {
    struct POPDOGE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<POPDOGE>, arg1: 0x2::coin::Coin<POPDOGE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<POPDOGE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POPDOGE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: POPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPDOGE>(arg0, 6, b"POP DOGE", b"PDOGE", b"https://www.popdogecoin.com/  https://x.com/popdoge_sui  https://t.me/PopDoge_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmQg43PLBPrTD2DELUhSx3KdbUqCwjv4YXDXG1RBcjRZ88")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<POPDOGE>, arg1: 0x2::coin::Coin<POPDOGE>) : u64 {
        0x2::coin::burn<POPDOGE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<POPDOGE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<POPDOGE> {
        0x2::coin::mint<POPDOGE>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

