module 0xd9ae8df44c4b1ae6f46dbaf2b6592a715dd8029fd0cfdc7e83658030494a7efb::est19 {
    struct EST19 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST19, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EST19>(arg0, 6, b"EST19", b"testing", b"sdfasd asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1738927647313-upload.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EST19>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EST19>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

