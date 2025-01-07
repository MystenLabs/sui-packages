module 0x772c6d8d1b28850dfe3b0b00ce591035a23dc7523d3417c97b1acb7d57e4bc65::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: 0x2::coin::Coin<YAWN>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YAWN>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"$YAWN", b"Yawn On Sui", b"Meet Yawn, the laziest, most laid-back character on Base. Yawn will bring financial freedom for every holders.   Website: https://www.yawnsui.xyz/      Twitter:  https://x.com/yawn_onsui     Telegram: http://t.me/yawnonsui  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUC1bkJ83pPpPgAHfu5dHUS3c1RzTFyioHwKSmUSkKosx")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: 0x2::coin::Coin<YAWN>) : u64 {
        0x2::coin::burn<YAWN>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<YAWN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YAWN> {
        0x2::coin::mint<YAWN>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

