module 0x689e949fc29d388e1d672e0335f5336fc8f97ca6d862806b3d619709b114666d::trealsuiguy {
    struct TREALSUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREALSUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREALSUIGUY>(arg0, 6, b"TREALSUIGUY", b"The Real Sui Guy", x"4920616d2061207265616c20706572736f6e2e0a4920414d20544845204e4557204d454d45204b494e47204f46205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia5mpop5ihqinslglj3d2yqcuil3w5esxjnhbfiny7suanzvj3yay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREALSUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TREALSUIGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

