module 0x41bb3d9f58f8113e72a13aa6008fe09f2aeb97147026d05d472fb5aff8a2713::klo {
    struct KLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLO>(arg0, 9, b"KLO", b"Kalloo", b"Fany", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b0aa05a4-4003-48f3-aeea-4d55d1cc1ec6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

