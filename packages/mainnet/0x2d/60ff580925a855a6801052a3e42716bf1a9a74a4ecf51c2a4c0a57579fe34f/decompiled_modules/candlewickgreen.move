module 0x2d60ff580925a855a6801052a3e42716bf1a9a74a4ecf51c2a4c0a57579fe34f::candlewickgreen {
    struct CANDLEWICKGREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDLEWICKGREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDLEWICKGREEN>(arg0, 6, b"CandleWickGreen", b"TRUMPTON", b"\"Here is the clock, the Trumpton clock. Telling the time, steadily, sensibly; never too quickly, never too slowly. Telling the time for Trumpton\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_2b512fad2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDLEWICKGREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDLEWICKGREEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

