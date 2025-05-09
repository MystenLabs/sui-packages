module 0x1fead036b0e07882f7c127996c481a703de68071bd6a09a7ce49b8298e8d38ad::hstar_coin {
    struct HSTAR_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HSTAR_COIN>, arg1: 0x2::coin::Coin<HSTAR_COIN>) {
        0x2::coin::burn<HSTAR_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HSTAR_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HSTAR_COIN>>(0x2::coin::mint<HSTAR_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HSTAR_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSTAR_COIN>(arg0, 6, b"HSTAR_COIN", b"hstar coin", b"hstar's coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/4043284"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HSTAR_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSTAR_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

