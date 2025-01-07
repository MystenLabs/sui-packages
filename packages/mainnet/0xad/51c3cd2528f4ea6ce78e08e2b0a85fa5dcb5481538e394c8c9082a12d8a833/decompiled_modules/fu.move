module 0xad51c3cd2528f4ea6ce78e08e2b0a85fa5dcb5481538e394c8c9082a12d8a833::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FU>(arg0, 9, b"FU", b"Tofu", b"This token to get freedom ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/87c2ef08-5487-4f78-b29b-0781ff0627eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FU>>(v1);
    }

    // decompiled from Move bytecode v6
}

