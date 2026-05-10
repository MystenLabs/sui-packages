module 0x2ccd7002cf2b5969e55dfffa2fbc5c0939409dbc0f2b0feef30234217ca3e410::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP>(arg0, 6, b"PUMP", b"PUMP_on_SUI", b"PUMP ($PUMP) is the most bullish memecoin ever launched on the SUI blockchain, a pure community driven rocket, fueled by memes, momentum, and maximum pump energy. We exist to make holders rich, spread unapologetic bullish vibes across crypto, and prove that on SUI, the only direction is UP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihpu33vpc2pqslrd6wi7yo4qjhrczayne4dflkkb3zsc23gzrruiu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

