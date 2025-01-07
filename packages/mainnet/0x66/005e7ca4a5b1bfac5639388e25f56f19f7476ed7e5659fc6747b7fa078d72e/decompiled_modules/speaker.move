module 0x66005e7ca4a5b1bfac5639388e25f56f19f7476ed7e5659fc6747b7fa078d72e::speaker {
    struct SPEAKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEAKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEAKER>(arg0, 9, b"SPEAKER", b"2020", b"Is a memecoin that will give new investors to invest and generate rewards instantly, and it's also an avenue where more tokens can be mine.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c35ec0f-e4aa-4972-b613-8fd1f68d094b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEAKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEAKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

