module 0x22820abcc3f9b283c76e88afa3e4d7587a0a153b8ea9974d247d857752340b89::tomiii {
    struct TOMIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMIII>(arg0, 9, b"TOMIII", b"TOM", b"Hii tom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59187651-13dd-4dd6-9b91-d68b60de4979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

