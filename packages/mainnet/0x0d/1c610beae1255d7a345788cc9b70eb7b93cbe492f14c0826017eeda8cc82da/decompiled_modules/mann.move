module 0xd1c610beae1255d7a345788cc9b70eb7b93cbe492f14c0826017eeda8cc82da::mann {
    struct MANN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANN>(arg0, 9, b"MANN", b"Mann", x"46756e20546f6b656e2c2066726f6d20636f6d6d756e697479206f6620746865206368616e6e656c20e2809c447265616d20576f726b20696e2043727970746fe2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29922e1e-04c9-4027-b307-2a506bb909f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANN>>(v1);
    }

    // decompiled from Move bytecode v6
}

