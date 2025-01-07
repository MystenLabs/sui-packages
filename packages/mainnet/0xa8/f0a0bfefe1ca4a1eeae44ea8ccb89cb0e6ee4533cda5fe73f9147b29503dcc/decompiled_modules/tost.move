module 0xa8f0a0bfefe1ca4a1eeae44ea8ccb89cb0e6ee4533cda5fe73f9147b29503dcc::tost {
    struct TOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOST>(arg0, 9, b"TOST", b"ToastCoin", b" For bread winners everywhere", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d00f7013-b608-421a-aefe-3e3bd82b7a5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOST>>(v1);
    }

    // decompiled from Move bytecode v6
}

