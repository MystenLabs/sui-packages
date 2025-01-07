module 0x5501395d576eab432a07b57516ea47e27978e16ddb90e07050742618515c3120::wife {
    struct WIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFE>(arg0, 9, b"WIFE", b"RWIFE", b"Buy and Enjoy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e54c4e6-5003-45a4-9d92-d282826bcba7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

