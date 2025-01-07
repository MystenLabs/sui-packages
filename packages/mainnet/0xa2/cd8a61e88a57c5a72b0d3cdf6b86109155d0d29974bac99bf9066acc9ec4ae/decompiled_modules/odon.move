module 0xa2cd8a61e88a57c5a72b0d3cdf6b86109155d0d29974bac99bf9066acc9ec4ae::odon {
    struct ODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODON>(arg0, 6, b"ODON", b"SUIODON", x"244f646f6e20697320746865205765616c74682050726f746563746f72206f6e20245355490a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958995851.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ODON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

