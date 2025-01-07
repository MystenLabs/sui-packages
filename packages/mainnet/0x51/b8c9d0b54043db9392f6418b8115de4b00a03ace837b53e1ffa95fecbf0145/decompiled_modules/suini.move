module 0x51b8c9d0b54043db9392f6418b8115de4b00a03ace837b53e1ffa95fecbf0145::suini {
    struct SUINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINI>(arg0, 6, b"SUINI", b"Sydney SUIni", b"A tribute to renowned actress and crypt supporter Sydney Sweeney (and her tits)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/maxresdefault_d7feb1d332.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

