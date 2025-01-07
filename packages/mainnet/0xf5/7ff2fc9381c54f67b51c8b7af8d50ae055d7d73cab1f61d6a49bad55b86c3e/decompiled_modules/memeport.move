module 0xf57ff2fc9381c54f67b51c8b7af8d50ae055d7d73cab1f61d6a49bad55b86c3e::memeport {
    struct MEMEPORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEPORT>(arg0, 6, b"MEMEPORT", b"MEME PORT", b"Meme Port is the ultimate hub for trading memecoins and unleashing tools to maximize virality. Trade multiple tokens in a single click, create ports to earn fees, and leverage social tools to send your token straight to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/25345_9d91b4bf17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEPORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMEPORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

