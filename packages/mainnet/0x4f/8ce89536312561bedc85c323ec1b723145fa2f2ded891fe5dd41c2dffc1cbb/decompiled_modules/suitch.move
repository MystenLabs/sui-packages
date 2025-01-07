module 0x4f8ce89536312561bedc85c323ec1b723145fa2f2ded891fe5dd41c2dffc1cbb::suitch {
    struct SUITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCH>(arg0, 6, b"SUITCH", b"Suitch", b"Suitch on the lights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e1j_X9_BMR_400x400_5f359ff1e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

