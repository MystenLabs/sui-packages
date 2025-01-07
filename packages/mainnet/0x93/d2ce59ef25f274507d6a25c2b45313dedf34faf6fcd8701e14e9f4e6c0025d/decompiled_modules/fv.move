module 0x93d2ce59ef25f274507d6a25c2b45313dedf34faf6fcd8701e14e9f4e6c0025d::fv {
    struct FV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FV>(arg0, 9, b"FV", b"k", b"VNC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8985ff61-476b-49f4-aea7-fb18605656c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FV>>(v1);
    }

    // decompiled from Move bytecode v6
}

