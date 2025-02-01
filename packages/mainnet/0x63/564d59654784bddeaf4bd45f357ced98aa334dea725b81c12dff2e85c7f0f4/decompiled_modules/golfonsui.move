module 0x63564d59654784bddeaf4bd45f357ced98aa334dea725b81c12dff2e85c7f0f4::golfonsui {
    struct GOLFONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLFONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLFONSUI>(arg0, 6, b"GolfOnSui", b"GOF", b"A place were golfers and crypto heads can meet over the web space rather then on the course. This space allows business and money to be talked through telegram and by showing love for golf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_1_bfb7e7dcdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLFONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLFONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

