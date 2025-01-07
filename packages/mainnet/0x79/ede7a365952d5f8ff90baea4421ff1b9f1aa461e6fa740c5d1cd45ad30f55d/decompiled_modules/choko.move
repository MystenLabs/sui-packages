module 0x79ede7a365952d5f8ff90baea4421ff1b9f1aa461e6fa740c5d1cd45ad30f55d::choko {
    struct CHOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOKO>(arg0, 6, b"CHOKO", b"CHOKO THE CAT", b"fatest yet fastest yet cutest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5763_45663d63be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

