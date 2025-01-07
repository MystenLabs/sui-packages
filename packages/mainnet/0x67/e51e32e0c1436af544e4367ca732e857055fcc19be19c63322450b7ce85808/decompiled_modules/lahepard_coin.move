module 0x67e51e32e0c1436af544e4367ca732e857055fcc19be19c63322450b7ce85808::lahepard_coin {
    struct LAHEPARD_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAHEPARD_COIN>, arg1: 0x2::coin::Coin<LAHEPARD_COIN>) {
        0x2::coin::burn<LAHEPARD_COIN>(arg0, arg1);
    }

    fun init(arg0: LAHEPARD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAHEPARD_COIN>(arg0, 9, b"LAHEPARD_COIN", b"LAHEPARD_COIN", b"coin create by mqh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169073119")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAHEPARD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAHEPARD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAHEPARD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAHEPARD_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

