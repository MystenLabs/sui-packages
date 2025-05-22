module 0x369da8b648ba5a50d3a78e3ab5e9358935ad940df3c11bdd94f62b3f67a5b842::gaytus {
    struct GAYTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYTUS>(arg0, 6, b"GAYTUS", b"FUCK CETUS", b"FK CETUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747915575998.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAYTUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYTUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

