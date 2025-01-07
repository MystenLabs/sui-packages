module 0x566d05b25ae890b81031d11984e3462277c2e49cc700c6704d7b9c166350c7fa::owli {
    struct OWLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWLI>(arg0, 6, b"OWLI", b"SUI OWL", b"THE SUI OWL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/owli_2_69b993c182.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OWLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

