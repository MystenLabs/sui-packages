module 0x1280ba6605b7bb8565eb25136bd901bda54d5a69cb442181756e654a5f895442::jf {
    struct JF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JF>(arg0, 9, b"JF", b"KJ", b"CCC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7102c5bc-85b7-4c3c-bbd9-0781c02fad7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JF>>(v1);
    }

    // decompiled from Move bytecode v6
}

