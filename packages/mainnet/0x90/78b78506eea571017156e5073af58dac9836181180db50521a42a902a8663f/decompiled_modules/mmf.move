module 0x9078b78506eea571017156e5073af58dac9836181180db50521a42a902a8663f::mmf {
    struct MMF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMF>(arg0, 9, b"MMF", b"Meme fun", b"Meme for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1085c72-e045-472e-ba0b-20d44e7896e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMF>>(v1);
    }

    // decompiled from Move bytecode v6
}

