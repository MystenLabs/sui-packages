module 0xeca4bdc785ba1d3f6deecf3926aca33401b65408d05f6ff33bb9b92609697595::coon {
    struct COON has drop {
        dummy_field: bool,
    }

    fun init(arg0: COON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COON>(arg0, 6, b"COON", b"Fat Coon", b"just a sad fat racoona. Rugged one too many times....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1527478145_phillip_bankss_maxamilion_ab47cd2b81.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COON>>(v1);
    }

    // decompiled from Move bytecode v6
}

