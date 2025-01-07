module 0x23d1925ba5a065a0799e56d293706b830bff1d293fc5b23ac466c7a1a3dfd4af::DiamondHands {
    struct DIAMONDHANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIAMONDHANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIAMONDHANDS>(arg0, 6, b"DiamondHands", b"DIAMOND", b"A resilient cryptocurrency celebrating unwavering commitment and long-term vision. Designed for holders who prioritize strength and perseverance, DHT rewards loyalty and empowers a steadfast community of believers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmaBN5Won7e8EgZsCNiacuf4cGdMU7K6u8irvXVFUEjRdn")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIAMONDHANDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIAMONDHANDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

