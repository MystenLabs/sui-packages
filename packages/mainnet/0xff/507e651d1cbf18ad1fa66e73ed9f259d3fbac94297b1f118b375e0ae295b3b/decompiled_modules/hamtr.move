module 0xff507e651d1cbf18ad1fa66e73ed9f259d3fbac94297b1f118b375e0ae295b3b::hamtr {
    struct HAMTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMTR>(arg0, 6, b"HAMTR", b"HAMTARO", b"SUIHAMTARO is more than just a token, it represents a bold journey toward limitless possibilities. From the depths of ambition to the heights of success,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198838_628217a805.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

