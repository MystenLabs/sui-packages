module 0xef9f65305a6bc978aea73907762cdf58ecd880af6a0aebe3a2ff5657d314151::upd {
    struct UPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPD>(arg0, 9, b"UPD", b"UPDATE", x"55504441544520594f555220434f4d505554455220f09f92bb20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a56547a-33e5-4006-b0bd-d4a568222e69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

