module 0x95368badac2b1d9afd72f9007574009a1fe9c97a4de8ede574d4c316dc75437e::nnj {
    struct NNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNJ>(arg0, 9, b"NNJ", b"NINJA", b"NINJA MEME COIN FORE TRADING IN WEWE LUNCHPAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0c76f08c-ec7f-40d7-9e61-3fa702711c18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

