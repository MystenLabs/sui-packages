module 0x6dc4394e2e590549604d103b5d2f00e4a883f8e6de55553ad25520a10a0161d1::pangjim {
    struct PANGJIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANGJIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANGJIM>(arg0, 6, b"Pangjim", b"Suielephant", b"Swimming elephant for real freedom ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087992_c1ebe61db8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANGJIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANGJIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

