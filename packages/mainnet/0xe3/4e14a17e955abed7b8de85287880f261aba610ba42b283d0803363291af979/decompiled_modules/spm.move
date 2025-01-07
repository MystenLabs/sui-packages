module 0xe34e14a17e955abed7b8de85287880f261aba610ba42b283d0803363291af979::spm {
    struct SPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPM>(arg0, 9, b"SPM", b"Supermon", b"Top1sever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df6746d7-6037-4a00-b3f9-8b0335e4d93a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

