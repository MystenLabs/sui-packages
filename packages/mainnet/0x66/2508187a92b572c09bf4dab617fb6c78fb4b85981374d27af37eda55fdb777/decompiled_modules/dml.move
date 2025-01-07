module 0x662508187a92b572c09bf4dab617fb6c78fb4b85981374d27af37eda55fdb777::dml {
    struct DML has drop {
        dummy_field: bool,
    }

    fun init(arg0: DML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DML>(arg0, 9, b"DML", b"Dhamal", b"Dhamal is native meme coin on sui blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f19d23d-6b67-42d7-85b6-394fc7bdf92e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DML>>(v1);
    }

    // decompiled from Move bytecode v6
}

