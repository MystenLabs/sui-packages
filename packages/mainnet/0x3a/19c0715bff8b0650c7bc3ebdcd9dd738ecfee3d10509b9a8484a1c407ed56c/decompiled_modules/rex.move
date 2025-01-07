module 0x3a19c0715bff8b0650c7bc3ebdcd9dd738ecfee3d10509b9a8484a1c407ed56c::rex {
    struct REX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REX>(arg0, 6, b"REX", b"Suirex", b"Stay Up to date with suirex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037275_b22dc5fe7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REX>>(v1);
    }

    // decompiled from Move bytecode v6
}

