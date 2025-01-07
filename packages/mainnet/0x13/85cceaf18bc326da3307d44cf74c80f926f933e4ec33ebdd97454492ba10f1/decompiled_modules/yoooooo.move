module 0x1385cceaf18bc326da3307d44cf74c80f926f933e4ec33ebdd97454492ba10f1::yoooooo {
    struct YOOOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOOOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOOOOOO>(arg0, 9, b"YOOOOOO", b"Yoiu", b"Yoiuyyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47ad40d5-da4d-491e-b544-c4009b9dc251.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOOOOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOOOOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

