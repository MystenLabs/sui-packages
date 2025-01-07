module 0x49da9a862a122a851e949702de0f76b7635214c7fa573e46649bb09efae87417::choko {
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

