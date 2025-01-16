module 0x106380820a69a81e83651df37db7249dc004dfcfe3cb799999c4a91a2f1ece93::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"FLIP", b"Flip Frenzy", b"Flip Frenzy is powered by the Sui network, a next-generation blockchain known for its high throughput, low latency, and scalability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737039134472.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

