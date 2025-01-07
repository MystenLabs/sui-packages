module 0xdbba9fd4e1970bf51ac418c5bff80873958914ee78575fdd2fc79b99aa5ee194::shrk {
    struct SHRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRK>(arg0, 9, b"SHRK", b"The Shark", b"Fierce predatory sharks in the open sea ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a1b55fbb-997d-4ded-8688-0191b90dc46b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

