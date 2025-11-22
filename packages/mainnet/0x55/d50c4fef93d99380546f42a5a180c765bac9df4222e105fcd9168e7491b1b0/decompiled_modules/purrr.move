module 0x55d50c4fef93d99380546f42a5a180c765bac9df4222e105fcd9168e7491b1b0::purrr {
    struct PURRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRR>(arg0, 6, b"Purrr", b"Purrrrfect", b"Just purrrrfect", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/base1_2b19e4c03e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PURRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

