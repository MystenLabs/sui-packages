module 0x3e477625a8cf0e5013d20c1fe956636736a83ea2e3d1d054724b3b6f9d5c3f48::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"Nemo", b"Finding Nemo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nemo_1111aae181.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

