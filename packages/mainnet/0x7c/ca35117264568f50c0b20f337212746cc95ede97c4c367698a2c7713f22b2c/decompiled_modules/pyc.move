module 0x7cca35117264568f50c0b20f337212746cc95ede97c4c367698a2c7713f22b2c::pyc {
    struct PYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYC>(arg0, 6, b"PYC", x"506f6bc3a96d6f6e20596163687420436c7562", x"416c6c2074686520506f6bc3a96d6f6e206a7573742070756c6c656420757020746f2074686520596163687420436c7562206c6f6f6b696e672062617365642061732068656c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicj2mffjfxdvtuaf7yf6i474pyxtsokg7d6reyueohzwnpiuekq7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

