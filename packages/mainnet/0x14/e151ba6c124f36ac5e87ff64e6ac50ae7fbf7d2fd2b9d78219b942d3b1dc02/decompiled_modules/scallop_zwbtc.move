module 0x14e151ba6c124f36ac5e87ff64e6ac50ae7fbf7d2fd2b9d78219b942d3b1dc02::scallop_zwbtc {
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

