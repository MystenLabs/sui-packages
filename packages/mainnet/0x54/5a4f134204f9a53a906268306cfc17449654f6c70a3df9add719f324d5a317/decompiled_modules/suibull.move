module 0x545a4f134204f9a53a906268306cfc17449654f6c70a3df9add719f324d5a317::suibull {
    struct SUIBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBULL>(arg0, 9, b"SUIBULL", b"SUI BULL", b"Sui Bull Coin is your reliable friend on Sui! Charge through the crypto landscape with strength and resilience. https://suibull.tech/ - https://t.me/Suibullcon - https://x.com/bullsuicoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIBULL>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

