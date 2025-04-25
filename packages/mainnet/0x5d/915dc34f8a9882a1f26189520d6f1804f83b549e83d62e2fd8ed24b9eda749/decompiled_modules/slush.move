module 0x5d915dc34f8a9882a1f26189520d6f1804f83b549e83d62e2fd8ed24b9eda749::slush {
    struct SLUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUSH>(arg0, 6, b"SLUSH", b"Slush Wallet", x"596f7572204d6f6e65792e20556e737475636b2e0a4561726e2c20737761702c20616e64206578706c6f7265207365637572656c79206f6e20537569204e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LZ_Mu_FM_Kt_400x400_dbcaff6c0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

