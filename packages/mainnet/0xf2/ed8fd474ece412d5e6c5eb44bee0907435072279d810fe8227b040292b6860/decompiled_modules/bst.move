module 0xf2ed8fd474ece412d5e6c5eb44bee0907435072279d810fe8227b040292b6860::bst {
    struct BST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BST>(arg0, 9, b"BST", b"BOSSYCAT", b"A fluffy bossy cat meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/02da62c5-fa12-49f3-a591-b60488afa468.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BST>>(v1);
    }

    // decompiled from Move bytecode v6
}

