module 0x78e4ec4626e8756fc4dbf03fcbbdbab7100902a38a1a89331382a87af19db9bf::mota {
    struct MOTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTA>(arg0, 6, b"MOTA", b"Mota", b"Mota is the funniest meme token on SUI blockchain with a staking features ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056870_428e0c7404.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

