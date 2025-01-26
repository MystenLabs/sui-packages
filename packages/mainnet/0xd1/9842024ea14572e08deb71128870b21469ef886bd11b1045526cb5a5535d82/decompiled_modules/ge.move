module 0xd19842024ea14572e08deb71128870b21469ef886bd11b1045526cb5a5535d82::ge {
    struct GE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GE>(arg0, 6, b"GE", b"The Grand Exchange by SuiAI", b"green:wave2: Selling lobbies 150 ea!!.green:wave2: Selling lobbies 150 ea!!.green:wave2: Selling lobbies 150 ea!!.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/osrs_8a7a8a2e1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

