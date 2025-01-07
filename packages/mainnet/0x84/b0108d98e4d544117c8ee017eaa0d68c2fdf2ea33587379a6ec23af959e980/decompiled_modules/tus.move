module 0x84b0108d98e4d544117c8ee017eaa0d68c2fdf2ea33587379a6ec23af959e980::tus {
    struct TUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUS>(arg0, 6, b"TUS", b"Tusko", b"Tusko sui Tus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f95_GT_Nufgd0_OJK_Yspvku_OIKT_Yd_E_19f503d64c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

