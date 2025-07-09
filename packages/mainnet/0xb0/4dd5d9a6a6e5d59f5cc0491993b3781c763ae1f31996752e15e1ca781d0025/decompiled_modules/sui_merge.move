module 0xb04dd5d9a6a6e5d59f5cc0491993b3781c763ae1f31996752e15e1ca781d0025::sui_merge {
    struct SUI_MERGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_MERGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_MERGE>(arg0, 6, b"Sui Merge", b"Sui Merge On Sui", b"The ultimate coin-merging minigame built for the SUI community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiglvywdzrqnxkzynyzbmbrfo3jfkhtm5najde7xaukez2joo7rjem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_MERGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI_MERGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

