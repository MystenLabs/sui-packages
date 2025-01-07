module 0x698f18b9d1b165515a7afe068e6acb40f2813a3f3b66a1aeae31a5f6a8e0cdca::fy {
    struct FY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FY>(arg0, 9, b"FY", b"Fyou", b"Fuckyou", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/357a7663-2961-4415-bca9-e075baf77500.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FY>>(v1);
    }

    // decompiled from Move bytecode v6
}

