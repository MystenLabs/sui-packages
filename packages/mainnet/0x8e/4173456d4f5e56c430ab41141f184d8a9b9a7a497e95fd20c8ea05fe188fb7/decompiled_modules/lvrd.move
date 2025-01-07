module 0x8e4173456d4f5e56c430ab41141f184d8a9b9a7a497e95fd20c8ea05fe188fb7::lvrd {
    struct LVRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVRD>(arg0, 9, b"LVRD", b"Love Bird", b"This token had been created by Lovely little Love birds. Which Ticker would be LVRD. Siu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f147f64-a272-4e03-ab02-8a837eb2fde2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LVRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

