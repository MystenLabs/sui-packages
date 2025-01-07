module 0x7e09e56da3f059bfa3cd0da7a222c4921210101efa69085e09f52583c629b85d::wly {
    struct WLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLY>(arg0, 9, b"WLY", b"willy", x"536574207361696c20776974682057696c6c79436f696e3a2054686520616476656e7475726f75732063727970746f63757272656e637920746861742773206e617669676174696e6720756e636861727465642077617465727320746f206272696e672074726561737572652d66696c6c65642070726f6669747320616e642073776173686275636b6c696e672066756e20746f207468652063727970746f20736561732120f09f8fb4e2808de298a0efb88ff09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/440745f5-d55e-4419-98c4-b1d4564abc16.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

