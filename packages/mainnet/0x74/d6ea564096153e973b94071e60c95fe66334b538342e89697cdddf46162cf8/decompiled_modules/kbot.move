module 0x74d6ea564096153e973b94071e60c95fe66334b538342e89697cdddf46162cf8::kbot {
    struct KBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBOT>(arg0, 6, b"KBOT", b"Kingbot", b"Kingbot all utilities in one place", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yv_AAM_6_W4_AAZ_4_F1_ec297ba9aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

