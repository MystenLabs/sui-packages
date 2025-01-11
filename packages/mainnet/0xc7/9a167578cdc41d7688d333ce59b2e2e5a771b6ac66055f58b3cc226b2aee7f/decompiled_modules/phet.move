module 0xc79a167578cdc41d7688d333ce59b2e2e5a771b6ac66055f58b3cc226b2aee7f::phet {
    struct PHET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PHET>(arg0, 6, b"PHET", b"Crypto Prophet by SuiAI", b"https://x.com/CryptoProphet25", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Crypto_Prophet_eb85f96292_c81a2e2d44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PHET>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHET>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

