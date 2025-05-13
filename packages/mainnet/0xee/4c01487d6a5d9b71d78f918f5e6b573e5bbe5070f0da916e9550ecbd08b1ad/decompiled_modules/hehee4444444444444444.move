module 0xee4c01487d6a5d9b71d78f918f5e6b573e5bbe5070f0da916e9550ecbd08b1ad::hehee4444444444444444 {
    struct HEHEE4444444444444444 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHEE4444444444444444, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHEE4444444444444444>(arg0, 6, b"HEHEE4444444444444444", b"HEHE", b"hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiau7lbrt3e62nyqxbf52yqabl5bowuu7746twyel7b5yprno3mgda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHEE4444444444444444>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEHEE4444444444444444>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

