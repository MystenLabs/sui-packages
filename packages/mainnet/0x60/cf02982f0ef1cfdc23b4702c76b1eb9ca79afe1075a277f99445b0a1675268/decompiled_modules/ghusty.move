module 0x60cf02982f0ef1cfdc23b4702c76b1eb9ca79afe1075a277f99445b0a1675268::ghusty {
    struct GHUSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHUSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHUSTY>(arg0, 6, b"GHUSTY", b"ghusty", b"HAND DRAWN GHUSTY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_68c6a9a611.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHUSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHUSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

