module 0x6fb87d055620fb6a088f4452ebbd347964ca6ffe58705e924d729f2a54974b2d::frg {
    struct FRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRG>(arg0, 9, b"FRG", b"FROG", x"4c65617020696e746f20666f7274756e6520776974682046726f67436f696ef09f90b8f09f90b8f09f90b8f09f90b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c01b5ccc-cd20-4103-94a7-ba5153a4539d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

