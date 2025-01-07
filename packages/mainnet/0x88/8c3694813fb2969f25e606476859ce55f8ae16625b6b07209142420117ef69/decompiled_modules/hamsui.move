module 0x888c3694813fb2969f25e606476859ce55f8ae16625b6b07209142420117ef69::hamsui {
    struct HAMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAMSUI>(arg0, 6, b"HAMSUI", b"HAMMERHEAD SUI", b"The Coolest Shark on SUI ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x996374e9df45796fe8112663a37272af4d33e7531c67d21aaa5cc93b3d1ded5c_hhs_hhs_d609f1461f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

