module 0x14de92aa565e2e1f5c7aed84e76774e37e23e1d5ce23b4b7c708502864d2319f::ajsfklan {
    struct AJSFKLAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJSFKLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJSFKLAN>(arg0, 9, b"AJSFKLAN", b"AJSFKLAN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/dqLDGkJRtU2pyP1LUR95GsYVlBRHGtmKfmN4TKUu8bk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AJSFKLAN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJSFKLAN>>(v2, @0x4dc4ae114dcf6fb4e1bc66f492703a740fb8dc0d3186629e38765569dcca4f37);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AJSFKLAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

