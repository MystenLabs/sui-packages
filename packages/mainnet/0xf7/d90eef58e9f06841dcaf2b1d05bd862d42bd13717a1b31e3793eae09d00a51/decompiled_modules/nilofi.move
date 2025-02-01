module 0xf7d90eef58e9f06841dcaf2b1d05bd862d42bd13717a1b31e3793eae09d00a51::nilofi {
    struct NILOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NILOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NILOFI>(arg0, 6, b"NILOFI", b"Nigga Lofi", b"Born in the cold, raised by the night, pockets full of ice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6030410795898226618_b781c75fb7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NILOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NILOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

