module 0xa1cec9f957f992efe65656157319a0c54e01bca606cf82c766f508b97c59f2d9::hlnd {
    struct HLND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLND>(arg0, 9, b"HLND", b"Homelander", b"King of the sups", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b50a428-2202-40e8-9ad6-62ca0a225f8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLND>>(v1);
    }

    // decompiled from Move bytecode v6
}

