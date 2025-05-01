module 0x2340ae9bf334d80daba1f28f9de3f890f065cf4de28aa1b4f4620790e05c0724::lag {
    struct LAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAG>(arg0, 6, b"LAG", b"Lisan Al Gaib AI", b"AI that works between ecosystems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiesatoer5ao3b2mdxehg3a4fvkkmlv4tcyclvapwxswit5qtclk6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

