module 0x45b473e7fe01c950897c781628c0ee52516ab709dc0cfa46fe66095b9c582a3b::aquanite_sui {
    struct AQUANITE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUANITE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUANITE_SUI>(arg0, 6, b"AQUANITE SUI", b"AQUANITE", b"The ultimate rug-free meme on SUI. The AQUANITE is here to dominate all memes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiab4x47f44jig6e2zqbagkvbpeivuhghw6k7eomrcs4dpwd4gvms4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUANITE_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUANITE_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

