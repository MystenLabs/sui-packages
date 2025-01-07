module 0xe83099ddc5ad24a8dbb7694543d89b626fbdb3ce2bbf8f18c5101f85461a575c::melt {
    struct MELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELT>(arg0, 6, b"MELT", b"Melting FACE", b"Create New Vibe on meme contest lets take sui community to the Moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051250_f5aecadfa0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELT>>(v1);
    }

    // decompiled from Move bytecode v6
}

