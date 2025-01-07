module 0x6cb99cb7166f6db7cb5342863cb9843db002c733573aeaa3c6a79bbe92920cf9::awebo {
    struct AWEBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: 0x2::coin::Coin<AWEBO>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AWEBO>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: AWEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWEBO>(arg0, 6, b"$KEKE", b"KekeSui", b"I'm $keke, I'm Green and it will be fine, I'm not given up! I'm Still here and I'm staying.     https://x.com/kekesui_    https://t.me/kekeonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmcCNvfh1xo1HZJacumvkwadpr9n31Zu1wPaGrSB1bxmog")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWEBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWEBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: 0x2::coin::Coin<AWEBO>) : u64 {
        0x2::coin::burn<AWEBO>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<AWEBO>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<AWEBO> {
        0x2::coin::mint<AWEBO>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

