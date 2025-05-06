module 0x9689c305fb85cffdfde8a79bc2278d7387eba82b51fff8e2fd88a2ce3c7bef8c::akol {
    struct AKOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKOL>(arg0, 6, b"AKOL", b"ANALKOL", b"you kno what this is about, just spread your legs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqmem57ft7aqyywjromaex75iz7l2bnzl3hijuhrlcdy3hiiarhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKOL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

