module 0x1882554fcc9ecb50c231bfdb96c5db6c11208a7a7a90f9f28cb00c9337eb0b24::cl {
    struct CL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CL>(arg0, 9, b"CL", b"Cril", b"Ceiling?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0c76fc4-53c1-4827-85c3-40d350a8e2ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CL>>(v1);
    }

    // decompiled from Move bytecode v6
}

