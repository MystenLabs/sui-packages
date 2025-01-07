module 0xa78e96c33e1d82300a579b9f90376d09471cb2f2ac822c941237f7be0fc585f4::smilingfam {
    struct SMILINGFAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILINGFAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILINGFAM>(arg0, 9, b"SMILINGFAM", b"Smiling", b"Smping falm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d38fe5d-f1ac-41b7-b4d4-fcaa16e1c57b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILINGFAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILINGFAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

