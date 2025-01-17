module 0x1c53e45d14a012bc9d6854a627b986c00a56f1bf6ba1406a061d40a3266a5e4c::et {
    struct ET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ET>(arg0, 6, b"ET", b"Eric Trump", x"457865637574697665205669636520507265736964656e74206f6620546865200a5472756d70204f7267616e697a6174696f6e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2227_14939f69f6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ET>>(v1);
    }

    // decompiled from Move bytecode v6
}

