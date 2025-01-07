module 0xe16e198970633a845f3c96bfcd26ef02e1b11b10470f375ac46a94221dba907f::hpo {
    struct HPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPO>(arg0, 9, b"HPO", b"HIPPO", b"HIPPO is a fun meme token on the SUI ecosystem, featuring a charming hippo mascot. It unites meme lovers and crypto enthusiasts, fostering a vibrant community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd1e3c52-1f7f-43bd-b28b-b19f18bacb33-IMG_1159.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

