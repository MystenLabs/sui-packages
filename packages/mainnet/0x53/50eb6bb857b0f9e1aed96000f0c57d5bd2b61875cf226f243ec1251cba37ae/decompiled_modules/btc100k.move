module 0x5350eb6bb857b0f9e1aed96000f0c57d5bd2b61875cf226f243ec1251cba37ae::btc100k {
    struct BTC100K has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC100K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC100K>(arg0, 9, b"BTC100K", b"Bitcoin100K", b"BTC 100K refers to the idea or milestone of Bitcoin (BTC) reaching a price of $100,000 per coin. This level is often discussed by analysts, investors, and enthusiasts as a significant psychological and financial benchmark in the cryptocurrency market. The concept is tied to factors such as increasing adoption, institutional investment, scarcity due to Bitcoin's fixed supply (21 million coins), and its potential as a hedge against inflation. While speculative, hitting $100K would signify a major milestone in Bitcoin's journey toward mainstream acceptance and valuation growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5cf95cfb00ddd99d3a2250dbd93dce5bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC100K>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC100K>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

