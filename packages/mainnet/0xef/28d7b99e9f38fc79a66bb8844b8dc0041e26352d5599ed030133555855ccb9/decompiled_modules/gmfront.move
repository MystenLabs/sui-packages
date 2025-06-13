module 0xef28d7b99e9f38fc79a66bb8844b8dc0041e26352d5599ed030133555855ccb9::gmfront {
    struct GMFRONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMFRONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMFRONT>(arg0, 6, b"GMFRONT", b"GMFRONTT", b"GM FRONTT how ya doing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicono6m7gvkxyw2xr23z3idm62pjdye3vbteusji6bliqnexg3iya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMFRONT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GMFRONT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

