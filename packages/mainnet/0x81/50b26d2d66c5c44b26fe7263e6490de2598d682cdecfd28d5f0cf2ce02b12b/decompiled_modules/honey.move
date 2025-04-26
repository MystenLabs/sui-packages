module 0x8150b26d2d66c5c44b26fe7263e6490de2598d682cdecfd28d5f0cf2ce02b12b::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HONEY>(arg0, 9, b"HONEY", b"HON", b"fun = fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8d92e252-7219-43db-acf1-1e78f034b9aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

