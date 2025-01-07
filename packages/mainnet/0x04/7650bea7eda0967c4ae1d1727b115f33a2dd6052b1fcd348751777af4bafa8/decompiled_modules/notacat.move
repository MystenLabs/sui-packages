module 0x47650bea7eda0967c4ae1d1727b115f33a2dd6052b1fcd348751777af4bafa8::notacat {
    struct NOTACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTACAT>(arg0, 6, b"NOTACAT", b"Not a cat sui", b" It's totally not a cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241223_233541_857_76c493dbea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

