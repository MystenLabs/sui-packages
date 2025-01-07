module 0x65bafe1d96615096e20658c52c4f40e84742ee1deabc0e6037cc9318348af363::yolomeome {
    struct YOLOMEOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLOMEOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLOMEOME>(arg0, 9, b"YOLOMEOME", b"Meomeo", b"Yolo meo meo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cbd14ab0-1026-4988-b632-b7b5b9331c70.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLOMEOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOLOMEOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

