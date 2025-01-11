module 0xf036fb00230d4ed973ce2d90c4928b9a14312bcf6371f141aec6bd4454a51c37::sum {
    struct SUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUM>(arg0, 6, b"Sum", b"Suiman", b"Just a meme coin for fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0798_93905f2c54.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

