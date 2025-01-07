module 0x51deec10532cb5e75c66e779a09b4a1f59b92b1f696211dbad7586bb6d9ed65::suiperman {
    struct SUIPERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERMAN>(arg0, 6, b"Suiperman", b"suiper man", b"There's a starman waiting in the sky!...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6239_ede323ad0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

