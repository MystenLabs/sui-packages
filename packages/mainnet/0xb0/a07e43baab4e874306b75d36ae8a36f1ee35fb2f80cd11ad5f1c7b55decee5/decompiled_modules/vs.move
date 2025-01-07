module 0xb0a07e43baab4e874306b75d36ae8a36f1ee35fb2f80cd11ad5f1c7b55decee5::vs {
    struct VS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VS>(arg0, 9, b"VS", b"AEE", b"RTW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/24f68e38-00ae-4edb-88dd-35039401573a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VS>>(v1);
    }

    // decompiled from Move bytecode v6
}

