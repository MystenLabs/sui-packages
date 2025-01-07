module 0x8dfa7b021f4354bc36912b3f1849b06f4aebfdc03819dd6c7e6de4db819b1738::grum {
    struct GRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUM>(arg0, 6, b"Grum", b"Grum Coin", b"The most memegonist shitcoin in existence...   ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005219_24ac6f41dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

