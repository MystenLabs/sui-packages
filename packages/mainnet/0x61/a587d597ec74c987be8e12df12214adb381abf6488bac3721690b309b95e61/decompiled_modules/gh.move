module 0x61a587d597ec74c987be8e12df12214adb381abf6488bac3721690b309b95e61::gh {
    struct GH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GH>(arg0, 9, b"GH", b"W", b"Ad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43c0c99b-2c6a-4fb2-aa4f-f926db743816.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GH>>(v1);
    }

    // decompiled from Move bytecode v6
}

