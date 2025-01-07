module 0xfc108774ff31be07b80f1125888ca2cbe06189c165b107f767eb4973c023af61::zaxa {
    struct ZAXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAXA>(arg0, 9, b"ZAXA", b"ZAXA VAU", b"TEAM WORK IS THE KEY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8ef3c93-5e04-454c-899c-47d4ad9c12c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

