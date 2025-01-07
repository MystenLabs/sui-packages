module 0x45a844d3b1603b7897ba87e3773f73159cb504a71279f320e4c2f70113ec7ef0::df {
    struct DF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DF>(arg0, 9, b"DF", b"DFG", b"VCF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65ac59f1-e8c0-4478-ad2d-0adfa5b713f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DF>>(v1);
    }

    // decompiled from Move bytecode v6
}

