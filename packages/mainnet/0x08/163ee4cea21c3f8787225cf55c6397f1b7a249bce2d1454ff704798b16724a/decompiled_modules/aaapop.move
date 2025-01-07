module 0x8163ee4cea21c3f8787225cf55c6397f1b7a249bce2d1454ff704798b16724a::aaapop {
    struct AAAPOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPOP>(arg0, 6, b"AAAPOP", b"aaaPOPcat", b"It's aaaPOPcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_d877401d51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

