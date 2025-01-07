module 0xe5344e8d18ae55f13f75c3f8b6c8a414c462f2a43aacd494796e8a6a847f2550::bf {
    struct BF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BF>(arg0, 9, b"BF", b"Boyfriend", b"Distracted boyfriend, guy checking out annother girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0a71bc0-226c-40a6-806d-be2375e53390.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BF>>(v1);
    }

    // decompiled from Move bytecode v6
}

