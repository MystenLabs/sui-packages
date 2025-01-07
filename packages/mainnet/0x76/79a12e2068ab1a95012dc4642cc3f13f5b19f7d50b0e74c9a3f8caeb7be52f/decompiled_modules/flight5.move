module 0x7679a12e2068ab1a95012dc4642cc3f13f5b19f7d50b0e74c9a3f8caeb7be52f::flight5 {
    struct FLIGHT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIGHT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIGHT5>(arg0, 6, b"Flight5", b"Flight 5", x"456c6f6e204d75736b2d2d466c696768742035202057617463680a205374617273686970277320666966746820666c6967687420746573740a68747470733a2f2f782e636f6d2f5370616365582f7374617475732f31383435323130323834323730363832313738", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zu_CT_Ana_AA_Et_D_Hi_a3d34d882f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIGHT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIGHT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

