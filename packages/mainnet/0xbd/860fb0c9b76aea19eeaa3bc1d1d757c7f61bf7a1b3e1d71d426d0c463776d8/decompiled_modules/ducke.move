module 0xbd860fb0c9b76aea19eeaa3bc1d1d757c7f61bf7a1b3e1d71d426d0c463776d8::ducke {
    struct DUCKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKE>(arg0, 6, b"Ducke", b"Ducke Sui", b"Ducke The Corporate Blue Duck Is Here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiegqunfx62be6rcw4jc4jo4wm5l6tspfaeat6bb6ge7o7hota4tte")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

