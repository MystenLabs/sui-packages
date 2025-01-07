module 0xdfd6a0addc0b3d94c7907492b27348b6929c1b59b227c3b8de84f43089016fe9::pesto {
    struct PESTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PESTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PESTO>(arg0, 6, b"PESTO", b"PESTO SUI", b"PESTO SUI just meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doggo_5866dfe33c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PESTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PESTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

