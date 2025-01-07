module 0xaf274793d75e510d9774a8f9c2555bfb6f33cac399d3921746f0fb05568513e1::tms {
    struct TMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMS>(arg0, 6, b"TMS", b"The Meme Squad", b"At The Meme Squad, we are planting the seeds of a vibrant, tight-knit community. As we move forward, we will grow together, building a strong and prosperous future. With each passing year, our community will grow stronger, increasing the trust and value of our token. Join us on this exciting journey and be a part of something great!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_07_18_42_28_dc768d1fcc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

