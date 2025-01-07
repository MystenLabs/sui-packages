module 0x883dcea4d5826bb8c403b315e848b57d40d1f698a123c324b6cdfde25d7f19e5::gst {
    struct GST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GST>(arg0, 9, b"GST", b"gemstone ", b"A project for alll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4187cfe7-ce33-4f52-ad63-540fddc4916a-IMG_4616.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GST>>(v1);
    }

    // decompiled from Move bytecode v6
}

