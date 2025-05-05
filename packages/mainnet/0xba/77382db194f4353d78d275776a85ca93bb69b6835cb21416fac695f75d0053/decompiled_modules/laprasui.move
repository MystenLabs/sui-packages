module 0xba77382db194f4353d78d275776a85ca93bb69b6835cb21416fac695f75d0053::laprasui {
    struct LAPRASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAPRASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAPRASUI>(arg0, 6, b"LAPRASUI", b"LAPRAS", b"the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/131_d2820f8a2f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAPRASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAPRASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

