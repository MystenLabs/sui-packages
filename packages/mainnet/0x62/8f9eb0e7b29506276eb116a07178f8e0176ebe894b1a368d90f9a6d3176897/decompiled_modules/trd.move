module 0x628f9eb0e7b29506276eb116a07178f8e0176ebe894b1a368d90f9a6d3176897::trd {
    struct TRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRD>(arg0, 6, b"TRD", b"Trump dance", b"Fan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1049_580952e5ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

