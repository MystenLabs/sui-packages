module 0x3bbc000ddb6d4b8f55c6ff62371b458fcef561b3840bfea64da12d67eda2af13::aaaacat {
    struct AAAACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAACAT>(arg0, 9, b"AAAACAT", b"Aaacat", b"aacat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7a47d6e-96e2-4951-bb21-1f4d0f1791ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAAACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

