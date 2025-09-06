module 0x7364c09513dfcaa4c422aff67c8e50dd7d91a4b1c76ec03c8b3e4d0404171f5a::cpi {
    struct CPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPI>(arg0, 9, b"CPI", b"CABAL PRICE INDEX", x"5768656e2074686579207072696e7420e280942077652070756d702e207c20576562736974653a2068747470733a2f2f7062732e7477696d672e636f6d2f6d656469612f47796b2d765577585141414a3471703f666f726d61743d6a7067266e616d653d736d616c6c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gyk-vUwXQAAJ4qp?format=jpg&name=small")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

