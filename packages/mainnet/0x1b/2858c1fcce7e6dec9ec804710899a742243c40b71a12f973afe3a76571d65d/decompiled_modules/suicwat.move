module 0x1b2858c1fcce7e6dec9ec804710899a742243c40b71a12f973afe3a76571d65d::suicwat {
    struct SUICWAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICWAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICWAT>(arg0, 6, b"SUICWAT", b"SUI CWAT", b"Hold on a minute, the cwat of the oceans here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_3058b4f66c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICWAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICWAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

