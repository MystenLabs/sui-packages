module 0x6ab9c954bfde886c86ab15cd1865a9dc57c231e8c5f2f376e2b20c8a81d390b9::est14 {
    struct EST14 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST14, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST14>(arg0, 6, b"EST14", b"testing", b"sdfasd asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738921022730-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST14>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST14>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

