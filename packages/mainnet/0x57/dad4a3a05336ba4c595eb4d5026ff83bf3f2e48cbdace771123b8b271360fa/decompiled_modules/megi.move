module 0x57dad4a3a05336ba4c595eb4d5026ff83bf3f2e48cbdace771123b8b271360fa::megi {
    struct MEGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGI>(arg0, 6, b"Megi", b"MegiSui", b"Little Megalodon is ready to ship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000190_071f8b8205.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

