module 0xd047ae810622fbc990a01c8c505840c82ce5420b635a482ab5d72911b8bab86b::gslcn {
    struct GSLCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSLCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSLCN>(arg0, 9, b"GSLCN", b"Goslickcn ", x"436f6f6c20f09f988e20746f6b656e20666f7220636f6f6c2068756d616e7a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de0f444b-40d6-4e24-b3ef-f22889b39ce9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSLCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSLCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

