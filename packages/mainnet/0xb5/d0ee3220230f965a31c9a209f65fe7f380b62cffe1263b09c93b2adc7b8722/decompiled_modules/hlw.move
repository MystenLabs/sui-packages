module 0xb5d0ee3220230f965a31c9a209f65fe7f380b62cffe1263b09c93b2adc7b8722::hlw {
    struct HLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLW>(arg0, 9, b"HLW", b"healthy food", b"Healthy weed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/wVjLj8DI23Je_NWKg1cTsDe5VS3Fe4Mo5py6w7YVHGY")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HLW>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

