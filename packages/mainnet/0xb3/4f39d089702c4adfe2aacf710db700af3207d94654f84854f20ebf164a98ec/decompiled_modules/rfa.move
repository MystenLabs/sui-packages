module 0xb34f39d089702c4adfe2aacf710db700af3207d94654f84854f20ebf164a98ec::rfa {
    struct RFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFA>(arg0, 9, b"RFA", b"Roi Toffa ", b"The emblem of King Toffa ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/494fad69-3c03-415e-8df7-0c33d250dc79.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

