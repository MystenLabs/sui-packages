module 0xd8c0ffaa042e680ee214e743a87baa3158594cee4c9c5c165f76f2e314d1620e::satosui {
    struct SATOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSUI>(arg0, 6, b"SATOSUI", b"Satoshi Nakamoto", b"SATOSUI THE NEW MEMECOIN CREATED BY SATOSHI NAKAMOTO!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SATOSHI_5fb0c3ecd2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

