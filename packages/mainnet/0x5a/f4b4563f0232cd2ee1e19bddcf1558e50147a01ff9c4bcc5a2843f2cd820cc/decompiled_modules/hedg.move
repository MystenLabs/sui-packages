module 0x5af4b4563f0232cd2ee1e19bddcf1558e50147a01ff9c4bcc5a2843f2cd820cc::hedg {
    struct HEDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEDG>(arg0, 9, b"HEDG", b"Hedgehog", b"a cute hedgehog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5f1e7d15-c095-404f-9376-8c5f2e8a7dfe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

