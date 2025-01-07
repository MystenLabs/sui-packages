module 0xd494b6339cd03cf312539c4a65d18ed60429c8d8a50016112d655239b0a956f2::srex {
    struct SREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREX>(arg0, 6, b"SREX", b"SUIREX", b"Suirex i a the cryptocurrency memecoin goodzila", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037323_031078abb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

