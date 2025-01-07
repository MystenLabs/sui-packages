module 0x2d399a8b255de079d172c94c8a0c85cb48b3d742e46c531ad2d1b19e333931a7::jorkin {
    struct JORKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORKIN>(arg0, 6, b"JORKIN", b"jorkin", b"JORKIN IT ALL DAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042188_af7c6656ef.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JORKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

