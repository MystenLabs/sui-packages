module 0xdf2680dd9370242e7aa116254976d4c39f0657edb696493c2cc9fa74f026f45a::vlove {
    struct VLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLOVE>(arg0, 9, b"VLOVE", b"Love", b"Valentine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e15e13ae-c9e4-4c3b-9e0e-04a0dddba87e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

