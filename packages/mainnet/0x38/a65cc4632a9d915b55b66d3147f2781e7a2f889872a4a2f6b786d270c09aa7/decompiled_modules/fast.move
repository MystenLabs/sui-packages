module 0x38a65cc4632a9d915b55b66d3147f2781e7a2f889872a4a2f6b786d270c09aa7::fast {
    struct FAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAST>(arg0, 9, b"FAST", b"Fasters", b"The only way I could do that was ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64f40583-3ba8-4053-82ff-4fb5a8b4f670.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

