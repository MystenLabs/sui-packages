module 0x793f14864c37f42e4ebf3d9bae2776f3f0042c911ab4e5a2a6b4d1d9eccf88aa::gst {
    struct GST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GST>(arg0, 9, b"GST", b"gemstone ", b"A project for alll", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3a4dc7b-f208-4ad4-8319-30ea8592e485-IMG_4616.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GST>>(v1);
    }

    // decompiled from Move bytecode v6
}

