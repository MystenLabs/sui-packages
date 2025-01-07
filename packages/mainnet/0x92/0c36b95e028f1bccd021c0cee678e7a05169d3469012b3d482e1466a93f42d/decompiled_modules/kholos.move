module 0x920c36b95e028f1bccd021c0cee678e7a05169d3469012b3d482e1466a93f42d::kholos {
    struct KHOLOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHOLOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHOLOS>(arg0, 9, b"KHOLOS", b"Kholis Vi", b"November ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d199711c-0dfb-4c00-87c1-1b0a76c73b3f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KHOLOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHOLOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

