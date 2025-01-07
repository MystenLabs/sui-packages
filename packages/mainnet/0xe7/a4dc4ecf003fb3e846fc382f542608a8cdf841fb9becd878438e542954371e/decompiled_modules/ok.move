module 0xe7a4dc4ecf003fb3e846fc382f542608a8cdf841fb9becd878438e542954371e::ok {
    struct OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OK>(arg0, 9, b"OK", b"Bkqckes", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c0b0219-3fc3-44bf-bd05-f7a4debfb333.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OK>>(v1);
    }

    // decompiled from Move bytecode v6
}

