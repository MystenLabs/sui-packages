module 0x301c477171d533f34f3f675c140bd07b100978f2e61e905310d69ded1166496b::jizz {
    struct JIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIZZ>(arg0, 6, b"JIZZ", b"Jizz Doge", b"Before there was Doge, there was JIZZ DOGE .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcalh347cz6hd2l65wow3aovvwhlelti7iefx5u4jo4rqblw6wj4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIZZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

