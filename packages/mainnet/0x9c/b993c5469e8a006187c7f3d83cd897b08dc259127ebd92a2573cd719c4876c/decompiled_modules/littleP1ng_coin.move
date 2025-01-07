module 0x9cb993c5469e8a006187c7f3d83cd897b08dc259127ebd92a2573cd719c4876c::littleP1ng_coin {
    struct LITTLEP1NG_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LITTLEP1NG_COIN>, arg1: 0x2::coin::Coin<LITTLEP1NG_COIN>) {
        0x2::coin::burn<LITTLEP1NG_COIN>(arg0, arg1);
    }

    fun init(arg0: LITTLEP1NG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEP1NG_COIN>(arg0, 9, b"LITTLEP1NG_COIN", b"LITTLEP1NG_COIN", b"coin create by ping", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317857")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LITTLEP1NG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEP1NG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LITTLEP1NG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LITTLEP1NG_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

