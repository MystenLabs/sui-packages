module 0xf5c13514be810b268bf62297663844b017c9911be0192280fd2ce520cc68d5de::suirai {
    struct SUIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAI>(arg0, 6, b"SUIRAI", b"Suirai Pokemon Sleep Game", b"$SUIRAI enters the dreams of jeets and gives them nightmares and build  pokemon sleep to earn game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxmdxoseermimpjaqvjy7yakzuirruvx2md3sgegllalagrmiiay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIRAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

