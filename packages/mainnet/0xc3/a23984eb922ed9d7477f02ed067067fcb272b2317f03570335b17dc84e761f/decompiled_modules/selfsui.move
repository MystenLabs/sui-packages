module 0xc3a23984eb922ed9d7477f02ed067067fcb272b2317f03570335b17dc84e761f::selfsui {
    struct SELFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELFSUI>(arg0, 6, b"SELFSUI", b"selfsui shib", b"selfsui shib is now on chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/selfecare_b5a0a16066.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

