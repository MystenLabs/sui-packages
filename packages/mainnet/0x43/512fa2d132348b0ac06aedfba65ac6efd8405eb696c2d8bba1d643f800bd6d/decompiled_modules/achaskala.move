module 0x43512fa2d132348b0ac06aedfba65ac6efd8405eb696c2d8bba1d643f800bd6d::achaskala {
    struct ACHASKALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACHASKALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACHASKALA>(arg0, 9, b"ACHASKALA", b"Acaskala", b"Good to Trade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e5ee350-a3c5-431e-a0ff-fab30d722d8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACHASKALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACHASKALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

