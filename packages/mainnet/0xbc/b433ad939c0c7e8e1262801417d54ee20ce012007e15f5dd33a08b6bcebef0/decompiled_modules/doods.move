module 0xbcb433ad939c0c7e8e1262801417d54ee20ce012007e15f5dd33a08b6bcebef0::doods {
    struct DOODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODS>(arg0, 6, b"DOODS", b"Doods", x"4a757374206368696c6c20646f6f642e0a546865206d6f7374206368696c6c20636f6d6d756e697479206f6e205355492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Doodz_Pfp_8ac28d7a48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOODS>>(v1);
    }

    // decompiled from Move bytecode v6
}

