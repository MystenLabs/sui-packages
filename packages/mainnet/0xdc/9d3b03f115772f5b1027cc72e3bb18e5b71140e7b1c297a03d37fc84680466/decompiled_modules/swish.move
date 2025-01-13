module 0xdc9d3b03f115772f5b1027cc72e3bb18e5b71140e7b1c297a03d37fc84680466::swish {
    struct SWISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWISH>(arg0, 6, b"SWISH", b"Swish king of the sea", b"If you get in the water I will eat you. Swish swish I am naughty.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250111_221310_53c17b5faa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

