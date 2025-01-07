module 0xe6aeed79ba2b309097e6eae02ddd46c1c201d031f4f2ed78b340ddb4fb2bc2f::snoop {
    struct SNOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOP>(arg0, 6, b"SNOOP", b"Snoop in Suioup", b"R", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016190_f3791bd5bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

