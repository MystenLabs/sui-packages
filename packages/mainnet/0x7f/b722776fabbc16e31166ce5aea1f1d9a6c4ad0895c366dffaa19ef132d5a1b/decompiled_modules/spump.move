module 0x7fb722776fabbc16e31166ce5aea1f1d9a6c4ad0895c366dffaa19ef132d5a1b::spump {
    struct SPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPUMP>(arg0, 6, b"SPump", b"Sui Pump", b"$SPUMP is a chart-pumping meme token designed to drive market momentum, flexing its power to turn dips into green candles and create gains for its community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pumpok_76e08c38ca.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

