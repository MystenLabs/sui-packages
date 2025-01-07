module 0xc0d191e88989e8d69244bd81e0a606ba60f9969cd870b329558891f4934030bb::signa {
    struct SIGNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGNA>(arg0, 9, b"SIGNA", b"Signum", x"54686520636f6d6d756e6974792d64726976656e20746563686e6f6c6f6779207468617420706f77657273207468652063727970746f63757272656e6379205369676e6120285349474e41292e0a7369676e756d2e6e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30208c40-5014-44ce-955a-34526380c06c-IMG_20241005_141524_716.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

