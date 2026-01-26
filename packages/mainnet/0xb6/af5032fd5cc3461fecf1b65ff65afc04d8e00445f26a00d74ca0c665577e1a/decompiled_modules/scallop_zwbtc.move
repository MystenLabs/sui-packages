module 0xb6af5032fd5cc3461fecf1b65ff65afc04d8e00445f26a00d74ca0c665577e1a::scallop_zwbtc {
    struct SCALLOP_ZWBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_ZWBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_ZWBTC>(arg0, 8, b"zWBTC", b"zWBTC", b"Scallop interest-bearing token for zWBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wfjhhmii3hhz7wpqq55o4eh4dzocgoeewxbblakfojpxtiyt6aya.arweave.net/sVJzsQjZz5_Z8Id67hD8HlwjOIS1whWBRXJfeaMT8DA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_ZWBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_ZWBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

