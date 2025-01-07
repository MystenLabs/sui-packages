module 0xced71267b828dc60a99f5bd69d33c442c749141d885a75aa855208acdb20c040::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST>(arg0, 6, b"TRUST", b"Trust The Process On Sui", b"$TRUST the process and embrace your journey on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9fa89192e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

