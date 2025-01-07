module 0x4a7299382f169f7695695bf11f8f6baa94b4134c7b2ffb40966b7dba9316b4ef::nnj {
    struct NNJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NNJ>(arg0, 9, b"NNJ", b"NINJA", b"NINJA MEME COIN FORE TRADING IN WEWE LUNCHPAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/032a684a-efc2-4d1c-a687-85a2e5b1f462.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NNJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NNJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

