module 0xa72f8f5ad40bba409356a91229fa388cebbffe7652c53b1e568af2b51ce103b7::meme_xs {
    struct MEME_XS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME_XS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME_XS>(arg0, 9, b"MEME_XS", b"memexs", b"This token for future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e73595a-fc0e-4164-a991-b4c22cd59221.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME_XS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEME_XS>>(v1);
    }

    // decompiled from Move bytecode v6
}

