module 0xfd336cdd4422909a2d814b48b6b1515ecfe1ec93f875de36dff964cdef9736a9::saiyaran {
    struct SAIYARAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIYARAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIYARAN>(arg0, 6, b"SAIYARAN", b"Pokemon Worlds", b"You made the best decision of your life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiclgzkae6d5limzh3d3twc6cbffl4j36eehc36hjsu3xygkezgi6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIYARAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAIYARAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

