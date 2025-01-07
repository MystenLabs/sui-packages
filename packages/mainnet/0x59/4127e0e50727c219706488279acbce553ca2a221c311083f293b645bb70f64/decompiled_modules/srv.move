module 0x594127e0e50727c219706488279acbce553ca2a221c311083f293b645bb70f64::srv {
    struct SRV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRV>(arg0, 6, b"SRV", b"Suirvivor", b"A survivor is a fightersomeone who faces the toughest challenges life throws at them, whether its a disaster, illness, or personal struggle, and comes out stronger on the other side. They embody resilience, grit, and the will to keep going when the odds are against them.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/58235_D36_7_B0_C_40_E8_A74_C_547445_AAB_98_D_c69e918ddb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRV>>(v1);
    }

    // decompiled from Move bytecode v6
}

