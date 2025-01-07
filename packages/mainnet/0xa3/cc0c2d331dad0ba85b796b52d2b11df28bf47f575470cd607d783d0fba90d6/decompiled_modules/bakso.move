module 0xa3cc0c2d331dad0ba85b796b52d2b11df28bf47f575470cd607d783d0fba90d6::bakso {
    struct BAKSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKSO>(arg0, 9, b"BAKSO", b"Bakso Sui", x"57656c636f6d65202442616b736f202c2032207765656b73206f6c64202620746865206e65776573742053756d616e7472616e2074696765722063756220696e2074686520416e696d616c204b696e67646f6d20f09f9085", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62b7c937-fa74-4523-ab39-3938c0cb58fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKSO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAKSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

