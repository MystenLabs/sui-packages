module 0x1601b159711b33a1a0ea28cf869cf36b206f4e132ef6913019fc812a25645233::kamalaharrisdog {
    struct KAMALAHARRISDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KAMALAHARRISDOG>, arg1: 0x2::coin::Coin<KAMALAHARRISDOG>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KAMALAHARRISDOG>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAMALAHARRISDOG>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: KAMALAHARRISDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALAHARRISDOG>(arg0, 6, b"KAMALA", b"KamalaHarrisDOG", b"Who is the new dog in town that will take over White House?   https://www.kamhalla.xyz/   https://x.com/kammalaharrisdog   https://t.me/kamalaharrisdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmfC1aAH9KdgiSDwcdrnK7ZC2PnbhtN53JBkriwAuVEDVo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMALAHARRISDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALAHARRISDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<KAMALAHARRISDOG>, arg1: 0x2::coin::Coin<KAMALAHARRISDOG>) : u64 {
        0x2::coin::burn<KAMALAHARRISDOG>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<KAMALAHARRISDOG>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KAMALAHARRISDOG> {
        0x2::coin::mint<KAMALAHARRISDOG>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

