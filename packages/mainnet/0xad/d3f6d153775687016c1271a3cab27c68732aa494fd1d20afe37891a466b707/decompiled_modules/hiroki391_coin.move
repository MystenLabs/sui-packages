module 0xadd3f6d153775687016c1271a3cab27c68732aa494fd1d20afe37891a466b707::hiroki391_coin {
    struct HIROKI391_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIROKI391_COIN>, arg1: 0x2::coin::Coin<HIROKI391_COIN>) {
        0x2::coin::burn<HIROKI391_COIN>(arg0, arg1);
    }

    fun init(arg0: HIROKI391_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIROKI391_COIN>(arg0, 9, b"HIROKI391_COIN", b"Hiroki's", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/165958351?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIROKI391_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIROKI391_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIROKI391_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HIROKI391_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

