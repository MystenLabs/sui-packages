module 0xe7489f22f62160a1c87fd4d7bb29bba3e145ea98a0bb61619fc935531dc4194c::dfd {
    struct DFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFD>(arg0, 6, b"DFD", b"dsf", b"sdfsadf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gedrw_Fp_Xw_A_Aeb_r_4acb723c5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

