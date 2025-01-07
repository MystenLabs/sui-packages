module 0x848249c97be4f5c58abff06f2884ca3771f75f3c8db36bd198c66bc2e6bbb14a::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 9, b"PAPA", b"PEPE MAGA", b"PEPE MAGA all in one on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xd29da236dd4aac627346e1bba06a619e8c22d7c5.png?size=lg&key=b0bcfa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAPA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

