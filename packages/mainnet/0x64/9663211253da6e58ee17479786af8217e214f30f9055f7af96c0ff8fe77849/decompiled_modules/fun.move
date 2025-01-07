module 0x649663211253da6e58ee17479786af8217e214f30f9055f7af96c0ff8fe77849::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"Zippo", b"fun meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6d369e4-d84c-4bd2-820b-ade8f8d63a7e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

