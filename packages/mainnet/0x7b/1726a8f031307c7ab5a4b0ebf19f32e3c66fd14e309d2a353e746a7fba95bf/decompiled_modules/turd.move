module 0x7b1726a8f031307c7ab5a4b0ebf19f32e3c66fd14e309d2a353e746a7fba95bf::turd {
    struct TURD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURD>(arg0, 6, b"Turd", b"TurdBurger", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibfdclxjsnpwrmpnc7cc7tzgjy73w3a5tukstxhhjihanwwmqa2bm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TURD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

