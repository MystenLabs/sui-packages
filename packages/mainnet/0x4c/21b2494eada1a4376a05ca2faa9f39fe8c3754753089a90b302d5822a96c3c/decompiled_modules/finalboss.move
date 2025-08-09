module 0x4c21b2494eada1a4376a05ca2faa9f39fe8c3754753089a90b302d5822a96c3c::finalboss {
    struct FINALBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINALBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINALBOSS>(arg0, 6, b"FINALBOSS", b"Sui Final Boss", b"Sui final Boss is here and ready to takeover.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicb6eaohpkarjl2de7f2gyffi6whj27vofpfvkytoqh7wul2mcanm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINALBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FINALBOSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

