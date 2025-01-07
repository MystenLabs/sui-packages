module 0xd1fe58868d8eb819398737e353ad35e32a4e473dee908d8b8bb3e8611e1ffda9::scal {
    struct SCAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAL>(arg0, 6, b"ScAL", b"Sir Croak-A-Lot", b"Where no frog has hopped before.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735429171567.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

