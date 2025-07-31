module 0xf14a3ed90a14c1138e36ea9a6d8d7bdc44ec3fcc1eded24376fc91ea96dd617e::suineko {
    struct SUINEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEKO>(arg0, 6, b"SUINEKO", b"Sui Neko", b"SuiNeko isnt just another memecoin she is your purrfect, playful anime inspired catgirl mascot ruling sui chain with charm and chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkabknnqlyy3etshrafgxd7fkflmm37e3bh6bnizmkod4aig2paq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINEKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

