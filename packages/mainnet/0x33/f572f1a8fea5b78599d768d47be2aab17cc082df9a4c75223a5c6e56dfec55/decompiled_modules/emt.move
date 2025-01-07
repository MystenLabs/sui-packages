module 0x33f572f1a8fea5b78599d768d47be2aab17cc082df9a4c75223a5c6e56dfec55::emt {
    struct EMT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMT>(arg0, 9, b"EMT", b"Emmysatoch", b"Sax on toschi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb43915b-ab8f-413d-ac33-6393c8eca664.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EMT>>(v1);
    }

    // decompiled from Move bytecode v6
}

