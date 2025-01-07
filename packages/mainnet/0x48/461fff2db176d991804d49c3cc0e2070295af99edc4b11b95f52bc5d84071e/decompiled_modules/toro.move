module 0x48461fff2db176d991804d49c3cc0e2070295af99edc4b11b95f52bc5d84071e::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORO>(arg0, 9, b"TORO", b"Toro cat", b"Torocat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ef2a428-e774-4807-9172-b28f85fd1f6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

