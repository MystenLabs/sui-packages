module 0x6859bca45e96e5db3815e1ed850fc7ccfb93409903af911ded74eaddfb2e3af0::fly {
    struct FLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLY>(arg0, 6, b"FLY", b"Mormie", b"Mormie cat fly away", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MA_2o_GO_4g_d11117a5ba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

