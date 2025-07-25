module 0xfd36ea71c464a2a1f402fd891b4b0f4f37cd42d7a376ccf3d564e58205ae187f::wan {
    struct WAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAN>(arg0, 6, b"WAN", b"WWE", b"FUD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia56s2daz2l7qkqjhsu2zeiu6mowg3nr5ov2yhj3tvb5fxsnqixf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

