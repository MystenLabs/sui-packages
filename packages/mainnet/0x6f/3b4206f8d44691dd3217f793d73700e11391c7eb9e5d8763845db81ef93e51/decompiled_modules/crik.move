module 0x6f3b4206f8d44691dd3217f793d73700e11391c7eb9e5d8763845db81ef93e51::crik {
    struct CRIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRIK>(arg0, 6, b"CRIK", b"SUI CRIK", b"Sui Crik is just a blue bear, nothing more", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4dd28c6f_c22f_4f88_a45c_2ff0525fee0a_642bf7b08b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

