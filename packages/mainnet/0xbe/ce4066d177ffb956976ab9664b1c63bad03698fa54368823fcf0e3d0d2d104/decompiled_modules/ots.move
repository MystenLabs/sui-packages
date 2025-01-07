module 0xbece4066d177ffb956976ab9664b1c63bad03698fa54368823fcf0e3d0d2d104::ots {
    struct OTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OTS>(arg0, 6, b"OTS", b"Ote Moa", b"J'aime Ote le Moa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000026597_7ad9c22803.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OTS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

