module 0x80117390abaf76beeef05c90a566d01f1460710ac021373a38d3e740ff09c9c4::gtt {
    struct GTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GTT>(arg0, 9, b"GTT", b"GiangThen", b"GTT TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4ac52e5f-02eb-42b7-8c8e-8e2e1c212260.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

