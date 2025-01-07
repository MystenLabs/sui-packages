module 0x8f0dbe5cdf2312ef45f00e9c1f5c5cdd7b7de224e09196c97a538733b911503c::er {
    struct ER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ER>(arg0, 9, b"ER", b"HJF", b"DHFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/606c5815-8272-4c8f-8314-9c1dec391ef4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ER>>(v1);
    }

    // decompiled from Move bytecode v6
}

