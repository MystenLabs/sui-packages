module 0x2eb7369f7d2c7e0da2e8a4352eb24196ad999dbc7ab2c417b0097b1a3a8deb87::supersodawater_coin {
    struct SUPERSODAWATER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPERSODAWATER_COIN>, arg1: 0x2::coin::Coin<SUPERSODAWATER_COIN>) {
        0x2::coin::burn<SUPERSODAWATER_COIN>(arg0, arg1);
    }

    fun init(arg0: SUPERSODAWATER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSODAWATER_COIN>(arg0, 9, b"SUPERSODAWATER_COIN", b"SUPERSODAWATER", b"learning for letsmove, power by supersodawater", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167277163")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPERSODAWATER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSODAWATER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPERSODAWATER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPERSODAWATER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

