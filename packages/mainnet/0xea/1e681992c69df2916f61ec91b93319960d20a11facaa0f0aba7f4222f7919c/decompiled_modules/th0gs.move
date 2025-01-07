module 0xea1e681992c69df2916f61ec91b93319960d20a11facaa0f0aba7f4222f7919c::th0gs {
    struct TH0GS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH0GS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH0GS>(arg0, 6, b"Th0gs", b"Th0gs on sui", b"Hand of god on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731048803066.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH0GS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH0GS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

