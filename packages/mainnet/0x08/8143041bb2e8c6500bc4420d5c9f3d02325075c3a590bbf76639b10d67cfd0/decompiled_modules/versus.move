module 0x88143041bb2e8c6500bc4420d5c9f3d02325075c3a590bbf76639b10d67cfd0::versus {
    struct VERSUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSUS>(arg0, 9, b"VERSUS", b"Dog x hams", b"Dogs and hamster telegram", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c8cc3de-794e-4106-9114-8c4f459dbd87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERSUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VERSUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

