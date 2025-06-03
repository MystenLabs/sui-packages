module 0x48051bfa1830b51af7cac1a9003e9166e312e0ca90a555525c156ddf8adc2b52::pyc {
    struct PYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYC>(arg0, 6, b"PYC", x"506f6bc3a96d6f6e20596163687420436c7562", x"416c6c20506f6bc3a96d6f6e206e6f7720696e20426f72656420417065207374796c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicj2mffjfxdvtuaf7yf6i474pyxtsokg7d6reyueohzwnpiuekq7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

