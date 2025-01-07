module 0xb859ca251a404f6ff049209b80a4816ceff8ab9dfcb1b11a0eefd0e4129ed4f2::wcoinn {
    struct WCOINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCOINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCOINN>(arg0, 9, b"WCOINN", b"Wcoin", b"W coin trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b5f073e-311e-4815-a683-f2f5c147508d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCOINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCOINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

