module 0xd8a583c2a73870161852311232b8314ee40f96f21d1edf6dc8d912953959726d::migo {
    struct MIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGO>(arg0, 6, b"Migo", b"Amigos", x"546865206d656d6520636f696e2074686174277320736f206c6169642d6261636b2c20697427732070726163746963616c6c7920686f72697a6f6e74616c2e20566973696f6e3a0a496e2074686520666173742d706163656420776f726c64206f662063727970746f2c2077686572652065766572796f6e65277320726163696e6720746f20746865206e65787420626967207468696e672c20416d69676f732069732068617070790a6a757374206c6f756e67696e672061726f756e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730466837321.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

