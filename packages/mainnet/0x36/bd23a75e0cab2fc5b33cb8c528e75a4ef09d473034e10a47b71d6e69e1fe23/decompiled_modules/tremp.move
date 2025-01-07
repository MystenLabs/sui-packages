module 0x36bd23a75e0cab2fc5b33cb8c528e75a4ef09d473034e10a47b71d6e69e1fe23::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"Tremp", b"Sui Tremp", b"SUI TREMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_03_31_31_2dc22dad75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

