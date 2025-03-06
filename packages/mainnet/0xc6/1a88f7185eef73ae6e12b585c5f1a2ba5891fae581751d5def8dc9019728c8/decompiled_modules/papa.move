module 0xc61a88f7185eef73ae6e12b585c5f1a2ba5891fae581751d5def8dc9019728c8::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"PAPA", b"Papa Sui", b"Just an old Papa on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741231970185.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

