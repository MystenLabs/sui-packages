module 0xa92991b1fa9fd7a3c9a01164154313caa3aa5f874a3e0323eeac87c85096c080::groggo {
    struct GROGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGO>(arg0, 6, b"GROGGO", b"Sui Groggo By Matt Furie", b"Groggo the Blue Frog - aka Blue Pepe - is an original character from Matt Furies third book Mindviscosity. Follow his curious spirit and dreamlike adventures into Sui Memeland.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/new_head_1_jlp_My_Ele_cf4cdfb8bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

