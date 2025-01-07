module 0xf04559fa7be8f5132420b9f389594cfbbd624420cf73a9ec9100dde7a63ea2ee::hlgvm {
    struct HLGVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLGVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLGVM>(arg0, 9, b"HLGVM", b"Kfldl", b"Xnvmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6fbe36d-7e1f-4e5a-861a-f90e97d52320.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLGVM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLGVM>>(v1);
    }

    // decompiled from Move bytecode v6
}

