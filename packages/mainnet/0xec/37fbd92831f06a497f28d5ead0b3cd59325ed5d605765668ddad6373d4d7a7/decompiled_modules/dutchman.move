module 0xec37fbd92831f06a497f28d5ead0b3cd59325ed5d605765668ddad6373d4d7a7::dutchman {
    struct DUTCHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUTCHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUTCHMAN>(arg0, 9, b"DUTCHMAN", b"DutchmanS ", b"King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fdc760fc-28f6-4f19-a8e4-617620f6a74f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUTCHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUTCHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

