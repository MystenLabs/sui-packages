module 0x2648ad45b45958e5d1049f8963fedc118f85b5317fa644bc412134b59d2f84e2::fushi {
    struct FUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUSHI>(arg0, 6, b"FUSHI", b"Fushi", b"Fush on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034381_8d42e666a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

