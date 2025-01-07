module 0xd0fde5421f7d76bfcb736cef3079a866194bb7723155deb818525f2716841206::doodo {
    struct DOODO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODO>(arg0, 9, b"DOODO", b"DOREMON", b"What that this they", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7e8dec60-ba54-4da8-b0f7-8c2108ad7e8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODO>>(v1);
    }

    // decompiled from Move bytecode v6
}

