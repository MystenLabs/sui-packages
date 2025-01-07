module 0x386d73160b91b3ea07a2ef08247a6255323665ea814be1354fcb0411e32fdf15::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"Billy", b"BillySUI", b"Billy on Sui, that's it. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2763_a003e1dc48.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

