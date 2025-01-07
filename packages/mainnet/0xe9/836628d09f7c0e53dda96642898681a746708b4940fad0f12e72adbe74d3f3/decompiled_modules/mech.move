module 0xe9836628d09f7c0e53dda96642898681a746708b4940fad0f12e72adbe74d3f3::mech {
    struct MECH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MECH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MECH>(arg0, 6, b"MECH", b"The mechanic", b"This girl can fix your car and you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955828719.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MECH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MECH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

