module 0x8ecd38d58396021aad121624a6b92368f446a522c30c85c5c59f569b3b042360::schiggy {
    struct SCHIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHIGGY>(arg0, 6, b"Schiggy", b"schiggy", b"Schiggy finally on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6242_1ce4802dec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

