module 0x9acc071f71df5e509c15ab21cb13482a0bd21662598718df4bcb6ea2b41b8c52::tardd {
    struct TARDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDD>(arg0, 9, b"TARDD", b"TARD", b"TARDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07e7503c-d6ad-4299-94b3-06a6f87d1caa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

