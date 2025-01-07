module 0xc60ac99b56cdd2a268ba0e859db0c101a44082d569bdbb94e43fc2abf2b473f8::nth {
    struct NTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTH>(arg0, 9, b"NTH", b"Nothing", b"The best of the worst", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed6e3192-6f97-4518-997a-7ab0db250eb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

