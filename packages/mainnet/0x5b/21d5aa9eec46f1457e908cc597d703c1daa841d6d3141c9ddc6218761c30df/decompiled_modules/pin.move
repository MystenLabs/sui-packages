module 0x5b21d5aa9eec46f1457e908cc597d703c1daa841d6d3141c9ddc6218761c30df::pin {
    struct PIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIN>(arg0, 9, b"PIN", b"PINK", b"GOLOLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9b0ecf9-1811-4d8f-a55c-43c3b2e8cf45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

