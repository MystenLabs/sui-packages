module 0x567a6ff2c1ee2fb33e85b354ee64959efc2ed5bd2cd7b980f5c2c991e3f39792::fun {
    struct FUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUN>(arg0, 9, b"FUN", b"Fundy Meme", b"memme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6848095-4206-482a-ac92-4414f2aa07aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

