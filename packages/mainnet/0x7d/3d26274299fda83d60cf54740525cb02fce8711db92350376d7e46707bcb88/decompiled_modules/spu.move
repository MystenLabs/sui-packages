module 0x7d3d26274299fda83d60cf54740525cb02fce8711db92350376d7e46707bcb88::spu {
    struct SPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPU>(arg0, 6, b"SPU", b"Suipurr", b"The Purring Future of Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032685_a7cab893af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

