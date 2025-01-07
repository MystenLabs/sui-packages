module 0x7bbedd52e5c87785061ed2b792b97684d94fe8758278fece1afbe0ba294d91ee::father {
    struct FATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATHER>(arg0, 9, b"FATHER", b"ODIN", b"ODIN IS HOLY UTIMATE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e593cdb8-467e-4119-b3cb-30b40554f623.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

