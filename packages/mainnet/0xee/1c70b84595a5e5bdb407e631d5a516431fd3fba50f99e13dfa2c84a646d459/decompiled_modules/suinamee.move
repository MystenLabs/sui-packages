module 0xee1c70b84595a5e5bdb407e631d5a516431fd3fba50f99e13dfa2c84a646d459::suinamee {
    struct SUINAMEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAMEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAMEE>(arg0, 6, b"SUINAMEE", b"SUI Tsunami", b"The most aggressive shark in the Sui ocean. Zero lags, instant finality, pure liquidity. Ride the wave or get washed away!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1788714564831.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINAMEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAMEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

