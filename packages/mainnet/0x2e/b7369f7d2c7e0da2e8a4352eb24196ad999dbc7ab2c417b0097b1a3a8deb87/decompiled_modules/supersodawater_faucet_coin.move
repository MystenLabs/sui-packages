module 0x2eb7369f7d2c7e0da2e8a4352eb24196ad999dbc7ab2c417b0097b1a3a8deb87::supersodawater_faucet_coin {
    struct SUPERSODAWATER_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPERSODAWATER_FAUCET_COIN>, arg1: 0x2::coin::Coin<SUPERSODAWATER_FAUCET_COIN>) {
        0x2::coin::burn<SUPERSODAWATER_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: SUPERSODAWATER_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSODAWATER_FAUCET_COIN>(arg0, 9, b"SUPERSODAWATER_FAUCET", b"SUPERSODAWATER_FAUCET", b"supersodawater's first faucet coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167277163")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPERSODAWATER_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUPERSODAWATER_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPERSODAWATER_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPERSODAWATER_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

