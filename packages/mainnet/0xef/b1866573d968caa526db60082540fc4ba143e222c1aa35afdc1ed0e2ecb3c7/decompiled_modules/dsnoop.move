module 0xefb1866573d968caa526db60082540fc4ba143e222c1aa35afdc1ed0e2ecb3c7::dsnoop {
    struct DSNOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSNOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSNOOP>(arg0, 9, b"DSNOOP", b"Good snoop", b"Dood snoop token for good people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25a0886e-698e-4659-b39a-f8a94dc09926.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSNOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSNOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

