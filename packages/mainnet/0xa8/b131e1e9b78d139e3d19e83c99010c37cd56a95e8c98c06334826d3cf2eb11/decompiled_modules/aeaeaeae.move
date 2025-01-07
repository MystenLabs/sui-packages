module 0xa8b131e1e9b78d139e3d19e83c99010c37cd56a95e8c98c06334826d3cf2eb11::aeaeaeae {
    struct AEAEAEAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEAEAEAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEAEAEAE>(arg0, 6, b"AEAeaeae", b"aeaeae", b"aeaea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3dgifmaker03327_f26dae24af.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEAEAEAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEAEAEAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

