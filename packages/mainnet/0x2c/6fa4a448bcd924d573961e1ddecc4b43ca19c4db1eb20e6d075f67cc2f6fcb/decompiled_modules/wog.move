module 0x2c6fa4a448bcd924d573961e1ddecc4b43ca19c4db1eb20e6d075f67cc2f6fcb::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 6, b"Wog", b"Worm Dog", b"Worm + Dog = Wormdog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tfh9wp_74f11a34b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

