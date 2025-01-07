module 0x67dc3bdc256f19bd3f6dc3fbc14f63ffa4009c2d99211fb1a48cfc38fe345212::tn {
    struct TN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TN>(arg0, 9, b"TN", b"Tynok", b"A", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b85caaf-3f14-463c-bb52-ba292b1c2c8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TN>>(v1);
    }

    // decompiled from Move bytecode v6
}

