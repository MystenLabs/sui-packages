module 0x715c9d3572be64d146c979cc2ae34c9c498d9273435ee341f42d7cb5a907c7a6::suirrari {
    struct SUIRRARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRRARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRRARI>(arg0, 6, b"SUIRRARI", b"Ferrari on SUI", b"Sui's First Ferrari, a Ferrari for everyone?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953752558.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRRARI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRRARI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

