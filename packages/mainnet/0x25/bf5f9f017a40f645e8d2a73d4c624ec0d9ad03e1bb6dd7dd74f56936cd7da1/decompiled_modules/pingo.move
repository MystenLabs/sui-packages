module 0x25bf5f9f017a40f645e8d2a73d4c624ec0d9ad03e1bb6dd7dd74f56936cd7da1::pingo {
    struct PINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGO>(arg0, 6, b"PINGO", b"Sui Pingo", b"pingo - the coldest ordinal colony in the artctic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012825_39976ddf38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

