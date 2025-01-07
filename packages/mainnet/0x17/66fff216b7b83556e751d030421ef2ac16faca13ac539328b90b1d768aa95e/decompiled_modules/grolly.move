module 0x1766fff216b7b83556e751d030421ef2ac16faca13ac539328b90b1d768aa95e::grolly {
    struct GROLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROLLY>(arg0, 6, b"GROLLY", b"Sui Grolly", b"Grolly spreading the green gospel of memes while un earthing the juciest opportunities in the market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010379_891da7db1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

