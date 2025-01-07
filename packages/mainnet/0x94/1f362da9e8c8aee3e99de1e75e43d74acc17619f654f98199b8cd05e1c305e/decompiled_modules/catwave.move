module 0x941f362da9e8c8aee3e99de1e75e43d74acc17619f654f98199b8cd05e1c305e::catwave {
    struct CATWAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWAVE>(arg0, 6, b"CATWAVE", b"CAT WAVE", b"Legendary cat with wave story!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3807_a84edb2bc3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWAVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

