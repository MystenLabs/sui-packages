module 0xc2173e9fa9ad0387e70f9cdceabad51659b376b10f7229487ccaa18929acbea8::hrn {
    struct HRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRN>(arg0, 9, b"HRN", b"HARON", b"Haron will come to you) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62ea783e-7ea0-4879-ad16-e2d0fddf08be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

