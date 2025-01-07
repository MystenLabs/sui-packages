module 0x6be6a314194bb12c09d64fe14a33d9d9cf85a6600285b68966c5fe4b4bc7fda3::dutchman {
    struct DUTCHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUTCHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUTCHMAN>(arg0, 9, b"DUTCHMAN", b"DutchmanS ", b"King of the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0c6933e-5259-49de-a178-2116302c7b60.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUTCHMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUTCHMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

