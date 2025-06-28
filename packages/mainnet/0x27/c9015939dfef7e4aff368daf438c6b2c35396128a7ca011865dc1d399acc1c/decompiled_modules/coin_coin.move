module 0x27c9015939dfef7e4aff368daf438c6b2c35396128a7ca011865dc1d399acc1c::coin_coin {
    struct COIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN_COIN>(arg0, 9, b"COIN1", b"coin coin", b"the first coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/1b662988-8788-4d65-93b0-aea96a71e170.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

