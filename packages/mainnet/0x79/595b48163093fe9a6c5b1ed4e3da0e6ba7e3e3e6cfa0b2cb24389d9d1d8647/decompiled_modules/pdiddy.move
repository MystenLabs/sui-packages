module 0x79595b48163093fe9a6c5b1ed4e3da0e6ba7e3e3e6cfa0b2cb24389d9d1d8647::pdiddy {
    struct PDIDDY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PDIDDY>, arg1: 0x2::coin::Coin<PDIDDY>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PDIDDY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PDIDDY>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: PDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDIDDY>(arg0, 6, b"DIDDY", b"P.DIDDY", b"P. Diddy Memecoin $DIDDY is a cryptocurrency inspired by the larger-than-life personality of P. Diddy (Sean Combs).    https://x.com/pdiddysui   https://t.me/pdiddysui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmXNEFzsdmLBWQ1ZH5Q89sibNn5pzh55jxFCZx4jisbNX8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDIDDY>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<PDIDDY>, arg1: 0x2::coin::Coin<PDIDDY>) : u64 {
        0x2::coin::burn<PDIDDY>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<PDIDDY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PDIDDY> {
        0x2::coin::mint<PDIDDY>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

