module 0x2cdd0195a5edf16b659cd00e8e9e2224bff0ac1f138486ec007be76821f188cf::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEM>(arg0, 9, b"GEM", x"4469616d6f6e6420f09f928e", x"4a6f696e206269642047454d20636f6d6d756e69747920776974682064726f707320616e642067697665617761797320657665727964617920666f722065766572796f6e6520f09f928ef09f928ef09f928ef09f928ef09f928ef09f928ef09f928ef09f928e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/567e7c2d-b4c5-465d-a285-8980f165cc98-1000014108.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

