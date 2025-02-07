module 0x56763fe47e833c439b626b9c501b66bd1da10fbf42dde73e1a6884931346aef9::ye {
    struct YE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YE>(arg0, 6, b"YE", b"Kanye West", b"My name is Kanye and i love walking around completely naked", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_Z6_Aba_XT_9nk5_J3uih_N_Sj_BV_Uox_UT_Sos_Rb_D_Tk_Tf_AF_Mpump_46e9ce512e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YE>>(v1);
    }

    // decompiled from Move bytecode v6
}

