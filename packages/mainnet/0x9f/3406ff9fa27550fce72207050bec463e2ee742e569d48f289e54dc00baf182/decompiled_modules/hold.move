module 0x9f3406ff9fa27550fce72207050bec463e2ee742e569d48f289e54dc00baf182::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLD>(arg0, 9, b"HOLD", b"Big thing ", b"Just for fun buy and hold good news coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/855465e6-e6a4-4074-a373-7516c246ac1d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

