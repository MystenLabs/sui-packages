module 0x1d3541b57b0f9a11c72313f94c3fd07daad77d21674d943b75fac111b926aab1::stuirt {
    struct STUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STUIRT>(arg0, 6, b"STUIRT", b"Stuirt Griff", b"Young griff in a city full of snakes, Surviving the treacherous trenches! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/stuirt_b69bedacdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

