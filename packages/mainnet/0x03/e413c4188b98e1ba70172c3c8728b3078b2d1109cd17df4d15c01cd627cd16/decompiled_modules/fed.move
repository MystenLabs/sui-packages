module 0x3e413c4188b98e1ba70172c3c8728b3078b2d1109cd17df4d15c01cd627cd16::fed {
    struct FED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FED>(arg0, 9, b"FED", b"FUD", b"Fidycnhuczbjbcjvonglaptaichinh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6d8a7fa-d44e-4952-ab51-b57bb63eec40.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FED>>(v1);
    }

    // decompiled from Move bytecode v6
}

