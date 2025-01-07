module 0x6fa807834f127627a3eacb2373412e69e8daeefbffd9bda0066840eab2009f8f::hose {
    struct HOSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOSE>(arg0, 6, b"HOSE", b"HoseDogSui", b"HOSE, the rising star in the meme coin universe on  brings a playful twist with its dog-themed charm. Embrace the whimsical world of GARO, where crypto meets humor, and join the journey toward the next big meme coin sensation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001199_80e18481dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

