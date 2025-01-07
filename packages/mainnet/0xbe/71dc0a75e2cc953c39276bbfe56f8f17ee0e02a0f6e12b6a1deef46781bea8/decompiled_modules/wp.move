module 0xbe71dc0a75e2cc953c39276bbfe56f8f17ee0e02a0f6e12b6a1deef46781bea8::wp {
    struct WP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WP>(arg0, 9, b"WP", b"WAVEPAD", b"No probability", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c7d3db5-40db-4970-86c9-83bbeb491f70-1000044346.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WP>>(v1);
    }

    // decompiled from Move bytecode v6
}

