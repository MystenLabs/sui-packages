module 0xc09f92d1c6ddfff36d7863541a05f52c102237f3bc5cb9dff23c57685e4fa4b9::Hairy_Brain {
    struct HAIRY_BRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIRY_BRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIRY_BRAIN>(arg0, 9, b"BRAIR", b"Hairy Brain", b"hairy brains are here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzXGW5pXcAAohu7?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAIRY_BRAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIRY_BRAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

