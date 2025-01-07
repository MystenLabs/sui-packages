module 0x44049511c2df25696f7e5addf2e9435c34a59447414b6678c32af7e5bec17db8::korek {
    struct KOREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOREK>(arg0, 9, b"KOREK", b"Koreki", b"Krek krek krek..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d21f4f43-785f-497e-8bae-274f0765ddef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

