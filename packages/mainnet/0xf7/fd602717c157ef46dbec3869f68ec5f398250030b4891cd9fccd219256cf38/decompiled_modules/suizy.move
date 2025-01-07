module 0xf7fd602717c157ef46dbec3869f68ec5f398250030b4891cd9fccd219256cf38::suizy {
    struct SUIZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZY>(arg0, 6, b"SUIZY", b"Suizy", b"My mom will call your manager", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_164257_c9185ba723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

