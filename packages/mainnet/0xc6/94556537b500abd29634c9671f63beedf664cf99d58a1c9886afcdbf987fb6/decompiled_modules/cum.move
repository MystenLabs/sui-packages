module 0xc694556537b500abd29634c9671f63beedf664cf99d58a1c9886afcdbf987fb6::cum {
    struct CUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUM>(arg0, 6, b"CUM", b"Whalecum", b"By whales for whales Cumming for the trenches", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewl2rrejmv3i4afycl6pqijlroezygzj54hqhipy4eigmiiylxza")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

