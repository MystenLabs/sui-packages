module 0x981358176e3bd8172743097ccf0b889cefdf046b317ac215fba5a8239a3f5171::mong {
    struct MONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONG>(arg0, 9, b"MONG", b"CAT", b"MENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8f3d7ae3-ae32-4ee0-a71d-0838df8131a1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

