module 0xec56b335ed25b90996a5d4773e665ac35e6989925a801bbe34f114c9c11213d2::horsui {
    struct HORSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HORSUI>(arg0, 6, b"Horsui", b"Sui Horse", b"Just a cute Sui Horse on Sui.  The ticker is $Horsiu, pronounced Horsey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8732_35b95be96e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

