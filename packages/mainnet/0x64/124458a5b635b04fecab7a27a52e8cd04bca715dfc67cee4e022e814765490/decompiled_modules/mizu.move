module 0x64124458a5b635b04fecab7a27a52e8cd04bca715dfc67cee4e022e814765490::mizu {
    struct MIZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIZU>(arg0, 6, b"Mizu", b"MIZU IS SUI", x"4d697a752069732061204a6170616e65736520776f72642074686174206d65616e7320e2809c7761746572e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735923121918.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

