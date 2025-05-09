module 0x8849e655bd7d0094d76cffa182d4562be27ec1a3740b6dfc1ec672e197737f7e::bored {
    struct BORED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED>(arg0, 6, b"BORED", b"bored boyz club", b"Relaunch of the bored boyz club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigbqew2kdjs2pvrra5f5stjshpgvehzpetwwplxewal3rzwtn3sqi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

