module 0x48ce3987d65b3213182300a404672e7c36b0cf703ea0e38203f11b99f8abbbd7::tober {
    struct TOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOBER>(arg0, 9, b"TOBER", b"Uptober20", x"5570746f6265722020666573746976616c20666f7220737569205473756e616d69206d6f6f6e20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5d388dc-a783-42b8-8ad5-3445b334cf11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

