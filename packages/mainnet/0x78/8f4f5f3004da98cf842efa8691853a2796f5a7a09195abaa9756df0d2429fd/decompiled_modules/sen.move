module 0x788f4f5f3004da98cf842efa8691853a2796f5a7a09195abaa9756df0d2429fd::sen {
    struct SEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEN>(arg0, 9, b"SEN", b"Sens", b"Sens - auto for 1.3l MeMZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e8877b6-b005-4223-a360-e1ebe8e7caec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

