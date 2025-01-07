module 0x4ec2e03029b613f588dde50faf9b9cdcb1c61ed98035799aa91e72b4471a36d4::hishba {
    struct HISHBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HISHBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HISHBA>(arg0, 9, b"HISHBA", b"Khvs", b"Hhwvs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb7a6d6d-33fe-4691-8db4-27b2f5863112.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HISHBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HISHBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

