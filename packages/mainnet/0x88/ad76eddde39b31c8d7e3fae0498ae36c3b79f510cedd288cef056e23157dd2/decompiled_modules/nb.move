module 0x88ad76eddde39b31c8d7e3fae0498ae36c3b79f510cedd288cef056e23157dd2::nb {
    struct NB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NB>(arg0, 9, b"NB", b"VDB", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b42c294-9e43-459c-9c11-29d918770f32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NB>>(v1);
    }

    // decompiled from Move bytecode v6
}

