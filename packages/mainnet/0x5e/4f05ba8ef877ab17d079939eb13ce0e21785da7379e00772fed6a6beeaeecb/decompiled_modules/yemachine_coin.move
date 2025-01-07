module 0x5e4f05ba8ef877ab17d079939eb13ce0e21785da7379e00772fed6a6beeaeecb::yemachine_coin {
    struct YEMACHINE_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YEMACHINE_COIN>, arg1: 0x2::coin::Coin<YEMACHINE_COIN>) {
        0x2::coin::burn<YEMACHINE_COIN>(arg0, arg1);
    }

    fun init(arg0: YEMACHINE_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEMACHINE_COIN>(arg0, 9, b"YEMACHINE_COIN", b"YEMACHINE", b"learning for letsmove, power by yemachine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167276459")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YEMACHINE_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEMACHINE_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YEMACHINE_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YEMACHINE_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

