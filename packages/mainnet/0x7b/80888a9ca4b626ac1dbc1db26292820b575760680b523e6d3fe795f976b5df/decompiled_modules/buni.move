module 0x7b80888a9ca4b626ac1dbc1db26292820b575760680b523e6d3fe795f976b5df::buni {
    struct BUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNI>(arg0, 6, b"BUNI", b"Baby Uni", b"Iam Baby Uni", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7298_03b33cbc35.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

