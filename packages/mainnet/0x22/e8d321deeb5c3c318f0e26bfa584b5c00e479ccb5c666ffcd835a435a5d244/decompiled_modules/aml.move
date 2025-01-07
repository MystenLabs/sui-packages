module 0x22e8d321deeb5c3c318f0e26bfa584b5c00e479ccb5c666ffcd835a435a5d244::aml {
    struct AML has drop {
        dummy_field: bool,
    }

    fun init(arg0: AML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AML>(arg0, 6, b"AML", b"AMWAL INU", b"AMWAL INU 100% OWN BY COMMUNITY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000415771_eba017f4e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AML>>(v1);
    }

    // decompiled from Move bytecode v6
}

