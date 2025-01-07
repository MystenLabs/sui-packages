module 0x5bea87825dc868a3d3dd46cf25ed78587a25dbc1f233191207dea49b64fd3ad9::luozzedc_coin {
    struct LUOZZEDC_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LUOZZEDC_COIN>, arg1: 0x2::coin::Coin<LUOZZEDC_COIN>) {
        0x2::coin::burn<LUOZZEDC_COIN>(arg0, arg1);
    }

    fun init(arg0: LUOZZEDC_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUOZZEDC_COIN>(arg0, 9, b"LUOZZEDC_COIN", b"LUOZZEDC", b"learning for letsmove, power by luozzedc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/161659515")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUOZZEDC_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUOZZEDC_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LUOZZEDC_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LUOZZEDC_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

