module 0x2185cc1fc8490998d0a369fd5c0d92b1cd4a6911d0087fab44cae9b10e939cf4::wooff {
    struct WOOFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFF>(arg0, 9, b"WOOFF", b"woof", x"576f6f6620776f6f6620776f6f6620f09f90b620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c1e5153-89cc-41d8-929f-a1edcaf55dff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

