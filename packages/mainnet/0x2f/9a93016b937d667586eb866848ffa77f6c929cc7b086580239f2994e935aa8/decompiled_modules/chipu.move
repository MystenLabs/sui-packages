module 0x2f9a93016b937d667586eb866848ffa77f6c929cc7b086580239f2994e935aa8::chipu {
    struct CHIPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPU>(arg0, 9, b"CHIPU", b"Chipu Dog", b"Chipu Dog from Taiwain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54e4f36e-bee1-40e3-8557-8014419a9979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

