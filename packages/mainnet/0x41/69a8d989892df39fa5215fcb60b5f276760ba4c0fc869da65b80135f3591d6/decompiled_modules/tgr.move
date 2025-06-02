module 0x4169a8d989892df39fa5215fcb60b5f276760ba4c0fc869da65b80135f3591d6::tgr {
    struct TGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGR>(arg0, 6, b"TGR", b"PumpTIGER", b"Pump Tiger is the ultimate meme token on SUI Chain, launching exclusively through MOONBAGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicj7tes5fwzpft3zzmemxm4l4fbsdizjku7275cc2lnmdyelakdvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TGR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

