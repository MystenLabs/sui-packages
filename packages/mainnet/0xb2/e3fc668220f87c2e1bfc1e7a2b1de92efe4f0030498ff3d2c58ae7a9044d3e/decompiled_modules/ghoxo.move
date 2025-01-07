module 0xb2e3fc668220f87c2e1bfc1e7a2b1de92efe4f0030498ff3d2c58ae7a9044d3e::ghoxo {
    struct GHOXO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOXO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOXO>(arg0, 6, b"GHOXO", b"Sui Ghoxo", b"Just a memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011617_024d44c5bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOXO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOXO>>(v1);
    }

    // decompiled from Move bytecode v6
}

