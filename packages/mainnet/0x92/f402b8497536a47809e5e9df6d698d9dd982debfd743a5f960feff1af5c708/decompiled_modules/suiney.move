module 0x92f402b8497536a47809e5e9df6d698d9dd982debfd743a5f960feff1af5c708::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 6, b"SUINEY", b"SUINEY THE BEAR", b"Say welcome to Suiney to the SUI chain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5945ecda_adbd_4ed7_ba3b_6ae588af8302_57f6913d71.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

