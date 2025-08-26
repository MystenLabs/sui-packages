module 0xf7f4f333ae77c47f709a6784ddea7f665d086f32757d9ff90208e8823ee2abc8::drippy {
    struct DRIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRIPPY>(arg0, 6, b"Drippy", b"Drippy Hole", b"Make it happen. Top G of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiawp2enxusga32pzxxswmptoxs5isgweu3fsgjliifuly5ownhd3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRIPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

