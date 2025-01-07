module 0x3e912b22cc2f9932fcac4cc8cc2f6a551c1ee6677e476b52bab03208a623266d::mljn {
    struct MLJN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLJN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLJN>(arg0, 9, b"MLJN", b"Muljono", b"YO NDAK TAU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8109bf22-04fe-4ad8-912c-4b0d12b2a41e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLJN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLJN>>(v1);
    }

    // decompiled from Move bytecode v6
}

