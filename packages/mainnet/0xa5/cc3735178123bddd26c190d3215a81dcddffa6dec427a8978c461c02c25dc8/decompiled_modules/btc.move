module 0xa5cc3735178123bddd26c190d3215a81dcddffa6dec427a8978c461c02c25dc8::btc {
    struct BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 6, b"BTC", b"Suishi Nakamoto", b"BTC is the ultimate Tear Drop who can do it all! With his iconic mustache and boundless charm, he embodies the spirit of the SUI chaincreativity, community, and endless fun. BTC is the heartbeat of our vibrant ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241011_025738_6e4d794196.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

