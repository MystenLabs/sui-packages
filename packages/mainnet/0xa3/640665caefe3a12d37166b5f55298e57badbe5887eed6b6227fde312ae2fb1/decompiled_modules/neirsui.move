module 0xa3640665caefe3a12d37166b5f55298e57badbe5887eed6b6227fde312ae2fb1::neirsui {
    struct NEIRSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRSUI>(arg0, 6, b"NEIRSUI", b"NEIRASUI", b"NEIRA SUI is a cryptocurrency that symbolizes the wife of Neiro and is set to be launched on the promising Sui network. This new coin follows the success of NEIRA, which was initially launched on the Ethereum (ETH) network, where it experienced explosive performance and quickly stood out, leading to its listing on Binance, one of the largest cryptocurrency exchanges in the world. NEIRA SUI promises to expand on this successful trajectory by leveraging the innovation and features of the Sui network to reach an even larger audience and promote inclusion in the cryptocurrency space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_15_05_58_597639cf1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

