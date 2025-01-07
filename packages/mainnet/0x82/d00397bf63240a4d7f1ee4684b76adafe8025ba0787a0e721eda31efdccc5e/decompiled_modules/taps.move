module 0x82d00397bf63240a4d7f1ee4684b76adafe8025ba0787a0e721eda31efdccc5e::taps {
    struct TAPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAPS>(arg0, 9, b"TAPS", b"Tapswap", x"54617073776170206973206120756e697175652061707020746f206d696e652070726f746f636f6c2077686572652075736572732063616e20656e6761676520696e746f206461696c79206163746976697469657320746f20706172746963697061746520616e642067657420726577617264732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32b06fbc-c3b8-4042-aa64-11da37abb85d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

