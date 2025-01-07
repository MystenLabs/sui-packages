module 0xd3c9d0e25e6c7dcf06d2a53c2a0e44225eefe89cb47e784f9c1e1d3f50f45cb9::nas {
    struct NAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAS>(arg0, 6, b"NAS", b"Nasan", b"Nasan is one company", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a2_e3d11ad57a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

