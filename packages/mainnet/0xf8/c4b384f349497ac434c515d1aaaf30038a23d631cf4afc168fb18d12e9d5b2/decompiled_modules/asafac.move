module 0xf8c4b384f349497ac434c515d1aaaf30038a23d631cf4afc168fb18d12e9d5b2::asafac {
    struct ASAFAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASAFAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASAFAC>(arg0, 9, b"ASAFAC", b"bsdf", b"vasda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb3dbba2-e794-4d45-85c6-72f6a5af9985.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASAFAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASAFAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

