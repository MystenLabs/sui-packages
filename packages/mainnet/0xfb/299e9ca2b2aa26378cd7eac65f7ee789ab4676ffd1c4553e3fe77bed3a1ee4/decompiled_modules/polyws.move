module 0xfb299e9ca2b2aa26378cd7eac65f7ee789ab4676ffd1c4553e3fe77bed3a1ee4::polyws {
    struct POLYWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLYWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLYWS>(arg0, 6, b"POLYWS", b"PolyW on Sui", b"\"POLYWSUI  High Jump, Spiral Profits!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigx6r6anoeixclsi7htdqp7r6lnlwqqyoqa2knvyfxwgwuechjbxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLYWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLYWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

