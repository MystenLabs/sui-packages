module 0x85f415f7dc875c26bea1991ccc50f2c99d65eb2d85cf4b5eacc9a594b9c2e3d6::aaaath {
    struct AAAATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAATH>(arg0, 6, b"aaaATH", b"aaa ALL TIME HIGH", b"SUI Price since All Time High (ATH)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_c21888b703.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

