module 0x99f69072cc31c6b5fad0abd5832b405be721f220ec35676dbba7b80f88d507e6::yawnsui {
    struct YAWNSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YAWNSUI>, arg1: 0x2::coin::Coin<YAWNSUI>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YAWNSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YAWNSUI>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: YAWNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWNSUI>(arg0, 6, b"$YAWN", b"Yawn Sui", b"Meet Yawn, the sleepiest member of the group.   https://www.yawnsui.xyz/  https://x.com/yawn__sui   https://t.me/yawnsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://belaunchio.infura-ipfs.io/ipfs/QmUC1bkJ83pPpPgAHfu5dHUS3c1RzTFyioHwKSmUSkKosx")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAWNSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWNSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<YAWNSUI>, arg1: 0x2::coin::Coin<YAWNSUI>) : u64 {
        0x2::coin::burn<YAWNSUI>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<YAWNSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YAWNSUI> {
        0x2::coin::mint<YAWNSUI>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

