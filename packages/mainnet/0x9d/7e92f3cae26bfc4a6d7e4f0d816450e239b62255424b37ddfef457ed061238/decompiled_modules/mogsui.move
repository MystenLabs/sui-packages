module 0x9d7e92f3cae26bfc4a6d7e4f0d816450e239b62255424b37ddfef457ed061238::mogsui {
    struct MOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOGSUI>(arg0, 6, b"MOGSUI", b"MOG", b"First ever MOG on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1728_24b62def0a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

