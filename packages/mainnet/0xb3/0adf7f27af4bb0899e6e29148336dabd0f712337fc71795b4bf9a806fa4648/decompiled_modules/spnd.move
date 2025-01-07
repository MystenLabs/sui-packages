module 0xb30adf7f27af4bb0899e6e29148336dabd0f712337fc71795b4bf9a806fa4648::spnd {
    struct SPND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPND>(arg0, 9, b"SPND", b"SPEND", b"SPEND is a Utility Token. Used to buy any merchandise from shops with easy transaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d775735-1406-4be1-93fa-1a15fbcf4093.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPND>>(v1);
    }

    // decompiled from Move bytecode v6
}

