module 0x3e345686cb4c1742dbe07325cc103664a1f347460f1c84bfb8fa8d25878fe8fb::terbang {
    struct TERBANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TERBANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TERBANG>(arg0, 9, b"TERBANG", b"Ikan", b"Everything will be Ok.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86535bcc-8a86-4a98-b806-e8ec9a7f2881.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TERBANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERBANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

