module 0xc3b9c22582ea2d609e256b08ac38b4412112fc2c3f1ee72c24fb3de3070ba0ee::brian {
    struct BRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIAN>(arg0, 6, b"BRIAN", b"Just a chill Brian", b"Brian is ready to takeover the \"Chillguy\" spot and be the next mascot as Chillguy's mascot have copyright issues.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bry_b8f58622a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

