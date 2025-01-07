module 0xf5bf619570611e2768f86386f816fbc83f3d52cfb4db65bed76d7fca12509949::tosh {
    struct TOSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSH>(arg0, 6, b"TOSH", b"Toshi SUI", b"Toshi is the first blue fox on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86054f13412b45a2acdff174c2fc5422_c4bcc6661e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

