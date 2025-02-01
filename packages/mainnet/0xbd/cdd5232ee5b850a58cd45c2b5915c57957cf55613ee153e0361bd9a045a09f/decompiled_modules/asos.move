module 0xbdcdd5232ee5b850a58cd45c2b5915c57957cf55613ee153e0361bd9a045a09f::asos {
    struct ASOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASOS>(arg0, 6, b"ASOS", b"AItantic Sharks On Sui", b"Atantic Sharks  AI On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/new_ce27a8ca47.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

