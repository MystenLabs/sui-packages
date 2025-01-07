module 0xbace9308e08af60e6d3013f9735b36e965830cf8ebb23be6a822dbc157e0788f::ponk {
    struct PONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONK>(arg0, 6, b"PONK", b"PONK CTO", x"596f752074686f756768742024504f4e4b2077617320646561643f20576520686176656ee2809974206576656e20737461727465642050757368696e20502e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731160164726.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

