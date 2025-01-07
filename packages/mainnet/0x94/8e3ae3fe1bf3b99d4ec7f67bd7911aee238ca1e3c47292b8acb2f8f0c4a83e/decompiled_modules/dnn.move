module 0x948e3ae3fe1bf3b99d4ec7f67bd7911aee238ca1e3c47292b8acb2f8f0c4a83e::dnn {
    struct DNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNN>(arg0, 9, b"DNN", b"Smack ", b"Ckdndb is a good example ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ecdd972-3e1a-461c-822e-3a1ef9abccac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNN>>(v1);
    }

    // decompiled from Move bytecode v6
}

