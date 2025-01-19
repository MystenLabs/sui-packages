module 0x82380a9257547dde5388680bc0f8a7be5ba0dedd7c2f442efd62bb920f4d2e33::zuck {
    struct ZUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCK>(arg0, 9, b"ZUCK", b"ZUCK BUCKS", b"ZUCK official meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd1882f1-005f-43a4-ab18-648d8babc964.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

