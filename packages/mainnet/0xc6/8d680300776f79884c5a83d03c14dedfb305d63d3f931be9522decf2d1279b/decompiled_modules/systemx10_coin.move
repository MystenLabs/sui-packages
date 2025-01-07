module 0xc68d680300776f79884c5a83d03c14dedfb305d63d3f931be9522decf2d1279b::systemx10_coin {
    struct SYSTEMX10_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SYSTEMX10_COIN>, arg1: 0x2::coin::Coin<SYSTEMX10_COIN>) {
        0x2::coin::burn<SYSTEMX10_COIN>(arg0, arg1);
    }

    fun init(arg0: SYSTEMX10_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYSTEMX10_COIN>(arg0, 9, b"SYSTEMX10_COIN", b"SYSTEMX10", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/161659965")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYSTEMX10_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYSTEMX10_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYSTEMX10_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SYSTEMX10_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

