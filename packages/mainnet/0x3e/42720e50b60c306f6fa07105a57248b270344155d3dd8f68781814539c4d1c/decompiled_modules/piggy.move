module 0x3e42720e50b60c306f6fa07105a57248b270344155d3dd8f68781814539c4d1c::piggy {
    struct PIGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGY>(arg0, 6, b"PIGGY", b"PIGGY SUI", x"4f696e6b206f696e6b2e2e2e204f682c2049206d65616e2c20486921204d79206e616d652069732050494747592c206f7220796f752063616e206a7573742063616c6c206d65204c75636b792050696767792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/do_PY_Lqa_K_400x400_a14d4f50b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

