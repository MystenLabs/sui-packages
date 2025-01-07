module 0x47a50bd3479237fd9cf8ee8c4b1b04c74fd7c22981f10e10ae09e56cfb785e::bluep {
    struct BLUEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEP>(arg0, 6, b"BLUEP", b"BLUE EYED PANDA", b"Blue-eyed Panda, adorable at its finest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cute_panda_fedya_by_svetlana_akimova_111e1f2ea2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

