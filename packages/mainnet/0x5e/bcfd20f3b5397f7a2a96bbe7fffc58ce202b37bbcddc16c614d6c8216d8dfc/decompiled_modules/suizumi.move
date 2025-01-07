module 0x5ebcfd20f3b5397f7a2a96bbe7fffc58ce202b37bbcddc16c614d6c8216d8dfc::suizumi {
    struct SUIZUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZUMI>(arg0, 6, b"SUIZUMI", b"IZUMI THE ORIGINS NEIRO", b"Izumi is a symbol of the \"legend\" of savior dogs in Japan ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3938_26f0c13ee7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

