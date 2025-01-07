module 0xc4310fd81c05fb30e5fec5e4ed71c03e18f7173f32d947bf13d125160f96ee43::of {
    struct OF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OF>(arg0, 6, b"OF", b"hoes terminal", x"796f752067657420796f757220686f657320686572650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Fj_Dx5_Xh_A5_Xk_Rym_Rb_Ruv6_C3_U_Sa1jb_Mtof8f52_S_Yh_Kmfr_0e879bd479.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OF>>(v1);
    }

    // decompiled from Move bytecode v6
}

