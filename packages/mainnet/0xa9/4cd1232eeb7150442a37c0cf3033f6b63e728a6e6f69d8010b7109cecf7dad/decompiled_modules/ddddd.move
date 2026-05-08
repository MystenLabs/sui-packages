module 0xa94cd1232eeb7150442a37c0cf3033f6b63e728a6e6f69d8010b7109cecf7dad::ddddd {
    struct DDDDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDDDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDDDD>(arg0, 6, b"DDDDD", b"aaaaa", b"AAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihohvwj7zquu6yieasiobtujmazkwpskwezco5thw2ukcfu54k6hy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDDDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DDDDD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

