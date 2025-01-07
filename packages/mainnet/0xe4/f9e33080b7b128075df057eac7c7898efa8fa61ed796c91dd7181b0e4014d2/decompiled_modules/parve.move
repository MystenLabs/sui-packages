module 0xe4f9e33080b7b128075df057eac7c7898efa8fa61ed796c91dd7181b0e4014d2::parve {
    struct PARVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARVE>(arg0, 6, b"PARVE", b"Parve", b"Welcome to my world, where there are no rules, and trust me - Ive got more than a few tricks up my sleeve. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_23_39_02_2ddb9e8558.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

