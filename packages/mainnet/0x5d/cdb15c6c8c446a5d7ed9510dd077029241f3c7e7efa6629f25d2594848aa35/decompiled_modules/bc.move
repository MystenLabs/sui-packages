module 0x5dcdb15c6c8c446a5d7ed9510dd077029241f3c7e7efa6629f25d2594848aa35::bc {
    struct BC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BC>(arg0, 9, b"BC", b"Baco", b"Bacote", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63a90e15-6204-4b76-97a9-b0d250825dd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BC>>(v1);
    }

    // decompiled from Move bytecode v6
}

