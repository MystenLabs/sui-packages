module 0xce450fa0109a8189f8415c11b6346f8de349200199a6143fabfd3e36b9d2e498::muku {
    struct MUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUKU>(arg0, 9, b"MUKU", b"Muku", b"Wunderkid from Almaty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3064a51a-ab4d-4e43-b7af-b643eca0c93d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

