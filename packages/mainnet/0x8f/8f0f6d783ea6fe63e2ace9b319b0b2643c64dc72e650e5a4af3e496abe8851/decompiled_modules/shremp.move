module 0x8f8f0f6d783ea6fe63e2ace9b319b0b2643c64dc72e650e5a4af3e496abe8851::shremp {
    struct SHREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHREMP>(arg0, 6, b"SHREMP", b"Shrempin", b"Introducing $SHREMP, your next meme obsession", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snow_9ad3ad5dbc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

