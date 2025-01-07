module 0x77fa7aa72414e3b3e942c9a51b424626a00324e227cfeb4daa12ed6618cf251e::bobecto {
    struct BOBECTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBECTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBECTO>(arg0, 6, b"BOBECTO", b"BOBE CTO", b"COMMUNITY TAKE OVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039626_739db328fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBECTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBECTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

