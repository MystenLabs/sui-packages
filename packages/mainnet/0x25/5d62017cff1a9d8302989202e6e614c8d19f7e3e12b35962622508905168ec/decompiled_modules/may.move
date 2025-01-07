module 0x255d62017cff1a9d8302989202e6e614c8d19f7e3e12b35962622508905168ec::may {
    struct MAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAY>(arg0, 6, b"MAY", b"Maya On Sui", b"Maya Coin is an innovative cryptocurrency that blends a playful and creative spirit with cutting-edge financial technologies. Inspired by the elegance and determination of the dachshund breed, symbolized by our mascot Maya, this cryptocurrency aims to make decentralized finance accessible to everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Maya_6c7b56f5e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

