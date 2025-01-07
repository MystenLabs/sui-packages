module 0x6bb44c0061871254fd1c507d385bdea4db97d09ba464fcab0152c0f5baab1d79::trogdor {
    struct TROGDOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROGDOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROGDOR>(arg0, 6, b"TROGDOR", b"The Burninator", b"$TROGDOR The Bunrninator !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1111_d2d4b18d8b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROGDOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROGDOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

