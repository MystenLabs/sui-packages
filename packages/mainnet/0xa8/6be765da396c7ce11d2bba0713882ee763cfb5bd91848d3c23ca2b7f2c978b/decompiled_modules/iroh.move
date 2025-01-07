module 0xa86be765da396c7ce11d2bba0713882ee763cfb5bd91848d3c23ca2b7f2c978b::iroh {
    struct IROH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IROH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IROH>(arg0, 6, b"IROH", b"IROHGMI", b"CERTIFIED SUI TRADER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r_Xj_Pj_Iy_F_400x400_9331aff52d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IROH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IROH>>(v1);
    }

    // decompiled from Move bytecode v6
}

