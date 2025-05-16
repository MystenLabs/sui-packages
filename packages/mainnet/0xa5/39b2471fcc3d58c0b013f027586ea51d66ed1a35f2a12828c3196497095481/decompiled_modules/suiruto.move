module 0xa539b2471fcc3d58c0b013f027586ea51d66ed1a35f2a12828c3196497095481::suiruto {
    struct SUIRUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRUTO>(arg0, 6, b"Suiruto", b"SUIRUTO COIN", b"Enter the SUIRUTO World... The SUI Network stealthiest meme coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwjlc25m3kghro3jq5xcs3lhrryxd6ro7ij2d7o7dp3alee47vm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRUTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRUTO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

