module 0x2e37895861f347db96337154fb3a3311e061ad84faa6d2a0cfecdb529709c711::fuki {
    struct FUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKI>(arg0, 6, b"Fuki", b"Fuki Gang", b"https://www.fukigang.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y7s_Dxwqd_400x400_122094076c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

