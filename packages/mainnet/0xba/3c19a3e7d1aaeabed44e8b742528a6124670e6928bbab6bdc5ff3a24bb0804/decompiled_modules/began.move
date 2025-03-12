module 0xba3c19a3e7d1aaeabed44e8b742528a6124670e6928bbab6bdc5ff3a24bb0804::began {
    struct BEGAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEGAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEGAN>(arg0, 9, b"BEGAN", b"Began Token", b"A new token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEGAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEGAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEGAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

