module 0xf69aba92df44ec85d4186aafac90c5f86576cf725c9cf2deffd938c5c5cd05a3::pln {
    struct PLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLN>(arg0, 9, b"PLN", b"POLEN", b"Polen conquest token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/855d3bbf-9e52-49d3-b3ff-2e4c0f401650.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

